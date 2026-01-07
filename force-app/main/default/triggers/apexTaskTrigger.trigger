trigger apexTaskTrigger on Task (before insert, before update) {
    Set<Id> accountIds = new Set<Id>();

    // Step 1: Collect Account IDs from Tasks that have Description and a WhatId pointing to an Account
    for (Task t : Trigger.new) {
        if ((t.Description != null && t.Description.trim() != '') && t.WhatId != null && String.valueOf(t.WhatId).startsWith('001')) {
            accountIds.add(t.WhatId);
        }
    }

    Map<Id, Boolean> accountHasDescriptiveTask = new Map<Id, Boolean>();

    if (!accountIds.isEmpty()) {
        // Step 2: Get all Tasks related to those Accounts (we filter Description later in Apex)
        List<Task> existingTasks = [
            SELECT Id, WhatId, Description
            FROM Task
            WHERE WhatId IN :accountIds
        ];

        for (Task t : existingTasks) {
            if (t.Description != null && t.Description.trim() != '') {
                accountHasDescriptiveTask.put(t.WhatId, true);
            }
        }
    }

    // Step 3: Check each incoming Task
    for (Task t : Trigger.new) {
        if ((t.Description != null && t.Description.trim() != '') && t.WhatId != null && String.valueOf(t.WhatId).startsWith('001')) {
            if (accountHasDescriptiveTask.containsKey(t.WhatId)) {
                t.addError('A Task with a Description already exists for this Account. You cannot add another.');
            }
        }
    }
}
public with sharing class LoggedInUserDetailsCtrl {

    public User loggedInUser { get; set; }

    public LoggedInUserDetailsCtrl() {
        loggedInUser = [
            SELECT Id, Name, Email, Username, Profile.Name
            FROM User
            WHERE Id = :UserInfo.getUserId()
            LIMIT 1
        ];
    }
}
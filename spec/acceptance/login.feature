@login_feature
Feature: Login
  Scenario Outline: User can use login functionality
    Given I am on login page
    When I login with <email> as an email and <pass> as a password with <check> remember me
    Then Log in should be <state>

    Examples:
    | email                 | pass      | check     | state     |
    | 'lec1k2103@gmail.com' | testtest  | unchecked | succeeded |
    | 'lec1k2103@gmail.com' | testtest  | checked   | succeeded |
    | 'lec1k2103@gmail.com' | qwertqwer | unchecked | failed    |
    | 'test@test.com'       | testtest  | unchecked | failed    |
    | 'test@test.com'       | qwertqwer | unchecked | failed    |
    |  ''                   | testtest  | unchecked | failed    |
    | 'lec1k2103@gmail.com' |    ''     | unchecked | failed    |
    |          ''           |      ''   | unchecked | failed    |
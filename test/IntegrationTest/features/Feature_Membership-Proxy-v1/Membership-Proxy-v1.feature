Feature:
    Integration testing for Membership Proxy v1

    Scenario: Login success
        Given I set query parameters to
          | parameter | value                            |
          | apikey    | T8T7Iy4NFVyurP6vJeTRXbIDYFaslL4o |
        When I POST to /Login
        Then response code should be 200
        And response body path $.acstkn should not be null

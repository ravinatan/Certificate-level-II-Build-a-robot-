*** Settings ***
Documentation     Open the Slack desktop application and Send message on Slack
Library           RPA.Desktop.Windows
Library           RPA.Desktop
Library           DateTime

*** Variables ***
${Channel}=       xorion-rpa-team

*** Keywords ***
Open the Slack desktop application
    Open From Search    Slack    Slack    wildcard=True

*** Keywords ***
Send message on Slack
    Press Keys    Ctrl    K
    Type Text    xorion-rpa-team
    Send Keys To Input    {DOWN}{TAB}{DOWN}
    Send Keys To Input    GOOD-MORNING-TEAM    with_enter=False

*** Keywords ***
Shedule message
    Send Keys To Input    {TAB}{TAB}{RIGHT}{ENTER}{DOWN}{ENTER}

*** Keywords ***
Shedule date
    Send Keys To Input    {TAB}{TAB}{RIGHT}{ENTER}{DOWN}{ENTER}

*** Keywords ***
Shedule time
    Send Keys To Input    {TAB}{TAB}{RIGHT}{ENTER}{DOWN}{ENTER}

*** Tasks ***
Open Slack desktop application and send message
    Open the Slack desktop application
    Send message on Slack
    Shedule message
    Shedule date
    Shedule time

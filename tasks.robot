*** Settings ***
Documentation     Insert the samsung mobile data into excel file from amazon website.
Library           RPA.Browser.Selenium    auto_close=${FALSE}
Library           Collections
Library           RPA.HTTP
Library           RPA.Excel.Files
Library           RPA.FileSystem
Library           RPA.RobotLogListener
Library           RPA.Tables
Library           html_Tables.py

*** Tasks ***
Insert the samsung mobile data into excel file from amazon website
    Open the website
    Search Samsung Mobiles
    Get HTML Data into table

*** Keywords ***
Open the website
    Open Available Browser    https://www.amazon.in/
    Maximize Browser Window

Search Samsung Mobiles
    Wait Until Element Is Visible    xpath://*[@id="twotabsearchtextbox"]
    Input Text    xpath://*[@id="twotabsearchtextbox"]    samsung Mobiles
    Click Button    nav-search-submit-button

Get HTML Data into table
    ${values}    Create List    Model Name    Wireless Carrier    Brand    Form Factor    Memory storage capacity    Price
    ${Column}    Set Variable    ${1}
    Create Workbook    Scrap_Data.xlsx
    FOR    ${n}    IN    @{Values}
        Set Cell Value    1    ${column}    ${n}
        ${Column}    Set Variable    ${${Column}+${1}}
    END
    Save Workbook
    Set Selenium Timeout    10
    @{MOBILE-LOCATORS}=    Create List    //*[@id="search"]/div[1]/div[1]/div/span[3]/div[2]/div[4]/div/div/div/div/div/div/div/div[2]/div/div/div[1]/h2/a/span
    ...    //*[@id="search"]/div[1]/div[1]/div/span[3]/div[2]/div[5]/div/div/div/div/div/div/div/div[2]/div/div/div[1]/h2/a/span
    ...    //*[@id="search"]/div[1]/div[1]/div/span[3]/div[2]/div[6]/div/div/div/div/div/div[2]/div/div/div[1]/h2/a/span
    ...    //*[@id="search"]/div[1]/div[1]/div/span[3]/div[2]/div[7]/div/div/div/div/div/div[2]/div/div/div[1]/h2/a/span
    ...    //*[@id="search"]/div[1]/div[1]/div/span[3]/div[2]/div[8]/div/div/div/div/div/div[2]/div/div/div[1]/h2/a/span
    ...    //*[@id="search"]/div[1]/div[1]/div/span[3]/div[2]/div[10]/div/div/div/div/div/div[2]/div/div/div[1]/h2/a/span
    ...    //*[@id="search"]/div[1]/div[1]/div/span[3]/div[2]/div[11]/div/div/div/div/div/div[2]/div/div/div[1]/h2/a/span
    ...    //*[@id="search"]/div[1]/div[1]/div/span[3]/div[2]/div[12]/div/div/div/div/div/div[2]/div/div/div[1]/h2/a/span
    ...    //*[@id="search"]/div[1]/div[1]/div/span[3]/div[2]/div[13]/div/div/div/div/div/div[2]/div/div/div[1]/h2/a/span
    ...    //*[@id="search"]/div[1]/div[1]/div/span[3]/div[2]/div[14]/div/div/div/div/div/div[2]/div/div/div[1]/h2/a/span
    @{COUNTS}=    Create List    ${1}    ${2}    ${3}    ${4}    ${5}    ${6}    ${7}    ${8}    ${9}    ${10}
    FOR    ${COUNT}    ${MOBILE-LOCATOR}    IN ZIP    ${COUNTS}    ${MOBILE-LOCATORS}
        ${handles}=    Get Window Handles
        Switch Window    ${handles}[0]
        Click Element When Visible    ${MOBILE-LOCATOR}
        ${handles}=    Get Window Handles
        Switch Window    ${handles}[1]
        ${Price}=    Get Text    xpath://*[@id="corePrice_desktop"]/div/table/tbody/tr[2]/td[2]/span[1]/span[2]
        ${Html_Table}=    Get Element Attribute    css:#productOverview_feature_div    outerHTML
        ${table}=    Read Table From Html    ${html_table}
        Add Table Row    ${table}    ${Price}
        ${dimensions}=    Get Table Dimensions    ${table}
        ${first_row}=    Get Table Column    ${table}    ${1}
        Open Workbook    Scrap_Data.xlsx
        ${table-Read}    Read Worksheet As Table
        ${count_table}    Get Length    ${table-Read}
        ${row}    Set Variable    ${${count_table}+${1}}
        ${column}    Set Variable    ${1}
        FOR    ${value}    IN    @{first_row}
            Set Cell Value    ${row}    ${column}    ${value}
            ${column}    Set Variable    ${${column}+${1}}
            Log    ${value}
        END
        Log    ${price}
        Save Workbook
        Close Window
    END


@echo off
title Call Someone with Twilio
echo Placing a phone call through Twilio...

:: Replace with your Twilio credentials
set ACCOUNT_SID=ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
set AUTH_TOKEN=your_auth_token
set FROM_NUMBER=+1234567890   :: Your Twilio number
set TO_NUMBER=+1987654321     :: The number you want to call

:: TwiML Bin URL or endpoint with call instructions
set TWIML_URL=http://demo.twilio.com/docs/voice.xml

curl -X POST https://api.twilio.com/2010-04-01/Accounts/%ACCOUNT_SID%/Calls.json ^
--data-urlencode "Url=%TWIML_URL%" ^
--data-urlencode "To=%TO_NUMBER%" ^
--data-urlencode "From=%FROM_NUMBER%" ^
-u %ACCOUNT_SID%:%AUTH_TOKEN%

echo.
echo Call request sent!
pause


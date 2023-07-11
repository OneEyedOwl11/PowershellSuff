$Number = Get-Random -Maximum 100
Invoke-RestMethod "https://jsonplaceholder.typicode.com/todos/$Number"
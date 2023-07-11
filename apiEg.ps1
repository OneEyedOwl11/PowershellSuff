$Body = @{
        Cook = "Barbara"
        Meal = "Pizza"
}

<#$Headers = @{
        Username = "safasfsdf"
        Password = "sdfasdga" 
}#>

$Parameters = @{
        Method = "POST"
        <#Header = ($Headers | ConvertTo-Json) this is an example of how you'd use the header section in the parameters#>
        Uri = "https://4besday4.azurewebsites.net/api/AddMeal"
        Body = ($Body | ConvertTo-Json)
        ContentType = "application/json"
}
Invoke-RestMethod @Parameters
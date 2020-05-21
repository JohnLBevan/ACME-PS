function ConvertTo-UrlBase64 {
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName="FromString")]
        [ValidateNotNull()]
        [string] $InputText,

        [Parameter(Mandatory = $true, ParameterSetName="FromByteArray")]
        [ValidateNotNull()]
        [byte[]] $InputBytes
    )

    process {
        if($PSCmdlet.ParameterSetName -eq "FromString") {
            $InputBytes = [System.Text.Encoding]::UTF8.GetBytes($InputText);
        }

        $encoded = [System.Convert]::ToBase64String($InputBytes);

        $encoded = $encoded.TrimEnd('=');
        $encoded = $encoded.Replace('+', '-');
        $encoded = $encoded.Replace('/', '_');

        return $encoded;
    }
}

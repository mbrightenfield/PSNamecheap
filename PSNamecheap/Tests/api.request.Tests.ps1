Remove-Module -Name PSNamecheap -ErrorAction SilentlyContinue -Force
Import-Module ./PSNamecheap/PSNamecheap.psm1 -Force

Describe "'api.request'" {
    It "should get a response from Namecheap API" {
        $domain_check = api.request @{Command = "namecheap.domains.check"; DomainList = "namecheap.com"}
        $domain_check.Type | Should -Be "namecheap.domains.check"
    }
}
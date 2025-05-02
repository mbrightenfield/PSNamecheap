BeforeAll {
    $here = (Split-Path -Parent $PSCommandPath) -replace "\\Tests", "\\Private"
    $sut = (Split-Path -Leaf $PSCommandPath) -replace '\.Tests\.', '.'
    . "$here\$sut"
}

Describe "'DomainSplit' Function Tests" {
    Context "Accepting input data" {
        BeforeAll {
            $domain_test = "example.com"
            $parts = 2
            $SLD = "example"
            $TLD = "com"
        }

        It "should accept a non-named DomainName parameter" {
            $domain = DomainSplit $domain_test
            $domain | Should -BeOfType ([System.Collections.Specialized.OrderedDictionary])
            $domain.Name | Should -Be $domain_test
            $domain.SLD | Should -Be $SLD
            $domain.TLD | Should -Be $TLD
        }

        It "should accept a DomainName parameter" {
            $domain = DomainSplit -DomainName $domain_test
            $domain | Should -BeOfType ([System.Collections.Specialized.OrderedDictionary])
            $domain.Name | Should -Be $domain_test
            $domain.SLD | Should -Be $SLD
            $domain.TLD | Should -Be $TLD
        }

        It "should accept DomainName and Parts parameters" {
            $domain = DomainSplit -DomainName $domain_test -Parts $parts
            $domain | Should -BeOfType ([System.Collections.Specialized.OrderedDictionary])
            $domain.Name | Should -Be $domain_test
            $domain.SLD | Should -Be $SLD
            $domain.TLD | Should -Be $TLD
        }

        It "should throw an error on invalid input" {
            {DomainSplit "invalid"} | Should -Throw
            
        }
    }
}
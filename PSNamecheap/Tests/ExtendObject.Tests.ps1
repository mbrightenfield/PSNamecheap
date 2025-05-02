BeforeAll {
    $here = (Split-Path -Parent $PSCommandPath) -replace "\\Tests", "\\Private"
    $sut = (Split-Path -Leaf $PSCommandPath) -replace '\.Tests\.', '.'
    . "$here\$sut"
}

Describe "'ExtendObject' Function Tests"{
    Context "Accept Input" {
        BeforeAll{
            $obj1 = @{
                a = "1"
                b = "2"
            }
            $obj2 = @{
                b = "3"
                c = "4"
            }
            $expected = @{
                a = "1"
                b = "3"
                c = "4"
            }
        }

        It "should append and overwrite data in obj1 from obj2" {
            $result = ExtendObject $obj1 $obj2
            $result.a | Should -Be $expected.a
            $result.b | Should -Be $expected.b
            $result.c | Should -Be $expected.c
        }
    }
}
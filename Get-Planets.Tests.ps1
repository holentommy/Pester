# in file Get-Planet.Tests.ps1
BeforeAll {
  . $PSScriptRoot/Get-Planets.ps1
}

Describe 'Get-Planet' {
  Context 'No parameters' {
    It 'Given no parameters, it lists all 8 planets' {
      $allPlanets = Get-Planet
      $allPlanets.Count | Should -Be 8
    }
  }

  Context "Filtering by order" {
    It 'Mercury is the first planet in our Solar System' {
      $allPlanets = Get-Planet
      $allPlanets[0].Name | Should -Be 'Mercury'
    }

    It 'Venus is the second planet in our Solar System' {
      $allPlanets = Get-Planet
      $allPlanets[1].Name | Should -Be 'Venus'
    }

    It 'Earth is the third planet in our Solar System' {
      $allPlanets = Get-Planet
      $allPlanets[2].Name | Should -Be 'Earth'
    }

    It 'Mars is the fourth planet in our Solar System' {
      $allPlanets = Get-Planet
      $allPlanets[3].Name | Should -Be 'Mars'
    }

    It 'Jupiter is the fifth planet in our Solar System' {
      $allPlanets = Get-Planet
      $allPlanets[4].Name | Should -Be 'Jupiter'
    }

    It 'Saturn is the sixth planet in our Solar System' {
      $allPlanets = Get-Planet
      $allPlanets[5].Name | Should -Be 'Saturn'
    }

    It 'Uranus is the seventh planet in our Solar System' {
      $allPlanets = Get-Planet
      $allPlanets[6].Name | Should -Be 'Uranus'
    }

    It 'Neptune is the eight planet in our Solar System' {
      $allPlanets = Get-Planet
      $allPlanets[7].Name | Should -Be 'Neptune'
    }

    It 'Planets have this order: Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune' {
      $allPlanets = Get-Planet
      $planetsInOrder = $allPlanets.Name -join ', '
      $planetsInOrder | Should -Be 'Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune'
    }
  }

  Context "Filtering by Name" {
    It "Given valid -Name '<Filter>', it returns '<Expected>'" -TestCases @(
      @{ Filter = 'Earth'; Expected = 'Earth' }
      @{ Filter = 'ne*'  ; Expected = 'Neptune' }
      @{ Filter = 'ur*'  ; Expected = 'Uranus' }
      @{ Filter = 'm*'   ; Expected = 'Mercury', 'Mars' }
    ) {
      param ($Filter, $Expected)

      $planets = Get-Planet -Name $Filter
      $planets.Name | Should -Be $Expected
    }

    It "Given invalid parameter -Name 'Alpha Centauri', it returns `$null" {
      $planets = Get-Planet -Name 'Alpha Centauri'
      $planets | Should -Be $null
    }

    It "Given invalid parameter -Name 'Helios', it returns `$null" {
      $planets = Get-Planet -Name 'Helios'
      $planets | Should -Be $null
    }
  }

  Context "Filtering human logic" {
    It 'Pluto is not part of our Solar System' {
      $allPlanets = Get-Planet
      $plutos = $allPlanets | Where-Object Name -EQ 'Pluto'
      $plutos.Count | Should -Be 0
    }
  }
}
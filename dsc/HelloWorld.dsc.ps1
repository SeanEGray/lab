configuration HelloWorld {
    node localhost {
        File 'TempDir' {
            Ensure = 'Present'
            DestinationPath = 'C:\Temp'
            Type = 'Directory'
        }

        File 'HelloWorld.txt' {
            Ensure = 'Present'
            DependsOn = '[File]TempDir'
            DestinationPath = 'C:\Temp\HelloWorld.txt'
            Type = 'File'
            Contents = 'Hello World!'
        }
    }
}

*This project has been created as part of the 42 curriculum by [dbotelho](https://github.com/sylvzzz)*

# Inception

### PID 1

Docker comunicates with PID 1, that should be the containerized app, not the shell executing the commands, so you use exec.

Exec places that command as PID 1, making that process the main one instead of the shell executing the commands.


### Without exec

```bash
#!/bin/sh
sleep 300  # this becomes a child process - bad practice
```

```
docker exec test ps

PID   USER     TIME  COMMAND
    1 root      0:00 {script.sh} /bin/sh /script.sh
    7 root      0:00 sleep 300
    8 root      0:00 ps
```


### With exec

```bash
#!/bin/sh
exec sleep 300  # this becomes PID 1 - best practice
```

```
docker exec test ps

PID   USER     TIME  COMMAND
    1 root      0:00 sleep 300
    8 root      0:00 ps
```


### Example of showing a PID (example for students from 42 that code in c)

```C
#include <stdio.h>
#include <unistd.h>

int main(void) {
    printf("PID: %d\n", getpid());  # this prints the program PID
    return 0;
}
```
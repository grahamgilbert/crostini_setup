crosh> vmc start termina
(termina) chronos@localhost ~ $ lxc profile unset default security.syscalls.blacklist
(termina) chronos@localhost ~ $ lxc profile apply penguin default
Profiles default applied to penguin
(termina) chronos@localhost ~ $ lxc restart penguin

# mariadb-10.5.8

## Build or Install in Nix Environment

### Build

To build this program by Nix, clone or download this project and run the following command at the root directory of the project:

```bash
nix-build
```

or the long version by specifying the file: `nix-build default.nix`, or even doing instantiate and realise step-by-step: `nix-store -r $(nix-instantiate default.nix)`.

### Install

To install this program in Nix Environment, run the following command at the root directory of the project:

```bash
nix-env -i -f default.nix
```

or the long version: `nix-env --install --file default.nix`.

### Inspect

You can get the out path by running `nix-store -q --outputs $(nix-instantiate default.nix)` or `nix eval '("${import ./default.nix}")'` before installation, or `nix-env -q --out-path --no-name hello` after installing.

To see the contents of the .drv file, run: `nix show-derivation $(nix-instantiate default.nix)` or `nix show-derivation $(nix-store -q --deriver $(nix eval '("${import ./default.nix}")' | cut -d '"' -f 1))`.

## Build Manually

You can build it manually with `gcc` by running:

```bash
gcc src/hello.c -o hello
```

## References

- [Nix Pills](https://nixos.org/nixos/nix-pills/)

## 初始化

- /vhs/mysql/是真实目录,根据自身位置进行对应配置

```shell
# 初始化权限
# 进入/vhs/mysql/mysql56/
sudo scripts/mysql_install_db --user=mysql --basedir=/vhs/mysql/mysql56/ --datadir=/vhs/mysql/mysql56/
# 修改my.cnf,如下面
nano my.cnf
# 创建
sudo mkdir /vhs/mysql/mysql56/tmp
sudo chmod 777 /vhs/mysql/mysql56/tmp
touch /vhs/mysql/mysql56/tmp/mysqld.pid
touch /vhs/mysql/mysql56/tmp/mysqld.log
# touch /vhs/mysql/mysql56/tmp/mysqld.sock
# chmod 777 /vhs/mysql/mysql56/tmp/mysqld.sock
# 启动数据库
# 测试的时候使用
bin/mysqld_safe &
# 已经调试完毕,请使用服务的方式启动,便于管理 (start stop restart)
sudo support-files/mysql.server start
# 修改mysql用户登录密码为root
sudo bin/mysqladmin -uroot password root
bin/mysql -uroot -proot
# 其他登录
bin/mysql -u root -p
# 注册到系统服务
# 常见错误
sudo cp support-files/mysql.server /etc/init.d/mysqld
# Warning: World-writable config file '/vhs/mysql/mysql56/my.cnf' is ignored
# Warning: World-writable config file '/vhs/mysql/mysql56/my.cnf' is ignored
# .. * The server quit without updating PID file (/vhs/mysql/mysql56/DESKTOP-F6LVIR9.pid).
# my.cnf文件权限644

```

- my.cnf文件

```cnf
[client]
port            = 3306
socket          = /vhs/mysql/mysql56/tmp/mysqld.sock

[mysqld]
port            = 3306
bind-address    = 0.0.0.0
socket          = /vhs/mysql/mysql56/tmp/mysqld.sock
server_id       =1
datadir =  /vhs/mysql/mysql56/
#slow_query_log  = 1
#慢查询时间 超过1秒则为慢查询
#long_query_time = 2
#slow_query_log_file = /var/log/mysql/slow.log
user=mysql
[mysqld_safe]
log-error=/vhs/mysql/mysql56/tmp/mysqld.log
pid-file=/vhs/mysql/mysql56/tmp/mysqld.pid
```

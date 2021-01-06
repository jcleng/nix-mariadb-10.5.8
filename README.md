# mariadb-10.5.8(linux-ubuntu)


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

## References

- [Nix Pills](https://nixos.org/nixos/nix-pills/)

## 初始化

```shell
# 初始化权限
# 进入
cd /nix/store/pxpc4b49rj335yqi027ch1hrsnq6myfl-mariadb-10.5.8/

# 初始化,只能在软件的根目录执行
sudo mkdir data
sudo chmod 777 data/
# 参数
./scripts/mysql_install_db --basedir=/nix/store/pxpc4b49rj335yqi027ch1hrsnq6myfl-mariadb-10.5.8 --datadir=/nix/store/pxpc4b49rj335yqi027ch1hrsnq6myfl-mariadb-10.5.8/data

# 提示如下,即可
# Installing MariaDB/MySQL system tables in './data' ...
# OK

# 打印基本信息,显示配置文件位置
my_print_defaults

# 修改配置信息如文章最后
touch ~/.my.cnf
vi ~/.my.cnf

# 运行一次,查看是否有错误
mysqld
# 或者指定data目录
chmod 777 /nix/store/pxpc4b49rj335yqi027ch1hrsnq6myfl-mariadb-10.5.8/data
mysqld --datadir=/nix/store/pxpc4b49rj335yqi027ch1hrsnq6myfl-mariadb-10.5.8/data

# 杀死进程
sudo pkill mysql
sudo pkill maria

# 后台运行
mysqld_safe &

# 重置密码
## 通过socket直接进入数据库
mysql
# 进入mysql控制台之后输入
ALTER USER 'root'@'localhost' IDENTIFIED BY '123456';
exit;

# 密码登录
mysql -u root -p

```

- my.cnf文件

```cnf
[client]
port            = 3306
socket          = /tmp/mariadb1058.sock

[mysqld]
port            = 3306
bind-address    = 0.0.0.0
socket          = /tmp/mariadb1058.sock
server_id       = 1
datadir =  /nix/store/pxpc4b49rj335yqi027ch1hrsnq6myfl-mariadb-10.5.8/data
#slow_query_log  = 1
#慢查询时间 超过1秒则为慢查询
#long_query_time = 2
#slow_query_log_file = /tmp/mariadb1058slow.log
# user=mysql
[mysqld_safe]
# log-error=/tmp/mariadb1058.log
# pid-file=/tmp/mariadb1058.pid
```

```shell
jcleng@DESKTOP-LQ95A7F /n/s/hnjcbp2y3lkkd06aln7z1bkq7f2kk3x2-mariadb-10.5.8> ps aux|grep maria
jcleng   14536  0.0  0.4 1347148 69404 tty1    Sl   17:29   0:00 /home/jcleng/.nix-profile/bin/mariadbd --basedir=/home/jcleng/.nix-profile --datadir=/nix/store/hnjcbp2y3lkkd06aln7z1bkq7f2kk3x2-mariadb-10.5.8/data --plugin-dir=/nix/store/hnjcbp2y3lkkd06aln7z1bkq7f2kk3x2-mariadb-10.5.8/plugin --log-error=/nix/store/hnjcbp2y3lkkd06aln7z1bkq7f2kk3x2-mariadb-10.5.8/data/DESKTOP-LQ95A7F.err --pid-file=DESKTOP-LQ95A7F.pid --socket=/tmp/mariadb1058.sock --port=3306
```
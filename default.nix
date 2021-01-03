with import <nixpkgs> {}; stdenv.mkDerivation {
  # 参考 https://gitee.com/jcleng/doc/blob/master/docs/linux下用cmake编译安装mysql.md
  # aria2c http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.35.tar.gz
  name = "mysql-5.6.35";

  # Source Code
  # See: https://nixos.org/nixpkgs/manual/#ssec-unpack-phase
  src = ./src;

  # Dependencies
  # See: https://nixos.org/nixpkgs/manual/#ssec-stdenv-dependencies
  buildInputs = [ coreutils gcc cmake ncurses ];

  # Build Phases
  # See: https://nixos.org/nixpkgs/manual/#sec-stdenv-phases
  configurePhase = ''
    declare -xp
  '';
  buildPhase = ''
    echo "开始编译:"
    # 编译错误再次编译需要删除该文件
    rm -rf CMakeCache.txt
    cmake \
-DCMAKE_INSTALL_PREFIX=$out/mysql56 \
-DMYSQL_DATADIR=$out/mysql56 \
-DSYSCONFDIR=$out/mysql56/etc \
-DWITH_MYISAM_STORAGE_ENGINE=1 \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_ARCHIVE_STORAGE_ENGINE=1 \
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
-DENABLED_LOCAL_INFILE=1 \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DEXTRA_CHARSETS=all \
-DMYSQL_TCP_PORT=3306 \
-DMYSQL_UNIX_ADDR=$out/mysqld.sock \
-DWITH_DEBUG=0
    make -j8
  '';
  installPhase = ''
    echo "安装:"
    make install
  '';
}

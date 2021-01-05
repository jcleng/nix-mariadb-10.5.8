with import <nixpkgs> {}; stdenv.mkDerivation {
  # 下载源码包,解压,移动到src目录
  # aria2c https://mirrors.tuna.tsinghua.edu.cn/mariadb/mariadb-10.5.8/source/mariadb-10.5.8.tar.gz
  # tar xvf mariadb-10.5.8.tar.gz
  # mv mariadb-10.5.8/ ./src
  name = "mariadb-10.5.8";

  # Source Code
  # See: https://nixos.org/nixpkgs/manual/#ssec-unpack-phase
  src = ./src;

  # Dependencies
  # See: https://nixos.org/nixpkgs/manual/#ssec-stdenv-dependencies
  buildInputs = [ coreutils gcc cmake ncurses bison gnutls bzip2 libaio];

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
-DCMAKE_INSTALL_PREFIX=$out/mariadb1058 \
-DMYSQL_DATADIR=$out/mariadb1058 \
-DSYSCONFDIR=$out/mariadb1058/etc \
-DWITH_MYISAM_STORAGE_ENGINE=1 \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_ARCHIVE_STORAGE_ENGINE=1 \
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
-DENABLED_LOCAL_INFILE=1 \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DEXTRA_CHARSETS=all \
-DMYSQL_TCP_PORT=3306 \
-DMYSQL_UNIX_ADDR=/tmp/mariadb1058.sock \
-DWITH_DEBUG=0
    make -j8
  '';
  installPhase = ''
    echo "安装:"
    make install
  '';
}

pkg_name="node-sass"
pkg_origin="cnunciato"
pkg_version="4.7.2"
pkg_description="Node.js bindings to libsass."
pkg_maintainer="Christian Nunciato <chris@nunciato.org>"
pkg_license=("MIT")
pkg_source="https://github.com/sass/node-sass/archive/v${pkg_version}.tar.gz"
pkg_shasum="21cdea5c6bf73825eaec06e78a0bcc54ed75c0953e05c72fe4b4316d756b9e35"
pkg_upstream_url="https://github.com/sass/node-sass"
pkg_deps=(core/coreutils core/node core/python2)
pkg_build_deps=(core/make core/gcc)
pkg_bin_dirs=(bin)

do_build() {
  npm install --progress false

  for b in node_modules/.bin/*; do
    echo "$b"
    fix_interpreter "$(readlink -f -n "$b")" core/coreutils bin/env
  done

  node scripts/build -f
}

do_install() {
  src_path="$HAB_CACHE_SRC_PATH/node-sass-${pkg_version}"

  fix_interpreter "$(readlink -f -n "$src_path/bin/node-sass")" core/coreutils bin/env
  items=(node_modules bin lib vendor package.json)

  for item in ${items[@]}; do
    cp -R $src_path/$item $pkg_prefix/
  done
}

do_strip() {
  return 0
}

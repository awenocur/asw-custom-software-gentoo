# Copyright 2017-2019 Adam Wenocur
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

CRATES="
autocfg-0.1.7
bitflags-1.2.1
cfg-if-0.1.10
clap-2.33.0
error-chain-0.11.0
float-cmp-0.3.0
fern-0.5.8
log-0.4.8
num-0.1.42
num-integer-0.1.41
num-iter-0.1.39
num-traits-0.2.8
phf-0.7.24
phf_shared-0.7.24
siphasher-0.2.3
simplecss-0.1.0
svgcleaner-0.9.5
svgparser-0.6.4
svgdom-0.10.5
textwrap-0.11.0
unicode-width-0.1.6
xmlparser-0.1.2
"

inherit cargo

DESCRIPTION="svgcleaner could help you to clean up your SVG files from the unnecessary data."
HOMEPAGE="https://github.com/RazrFalcon/svgcleaner"
SRC_URI="$(cargo_crate_uris ${CRATES})"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~ppc64 ~x86"

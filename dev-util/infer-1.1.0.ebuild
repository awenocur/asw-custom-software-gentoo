# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Infer is a static analysis tool for Java,
C++, Objective-C, and C."
HOMEPAGE="https://fbinfer.com"

DEPEND="dev-ml/menhir
	dev-ml/atdgen"


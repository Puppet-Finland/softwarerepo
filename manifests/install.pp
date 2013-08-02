#
# == Class softwarerepo::install
#
# Install software required by all repository management tools.
#
class softwarerepo::install {
    include gnupg
}

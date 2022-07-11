**Jiggle User Guide**

Temporary home for Jiggle User Guide

(interactive analyst user interface for AQMS)

Upon commit, the ``.gitlab-ci.yml`` file also builds (only on `master`) a copy of the documentation at https://aqms-swg.gitlab.io/jiggle-userdocs/

**Build and Run the Jiggle User Guide Locally**

Checkout the source code and run the following statements:
```
mkdocs build --clean
mkdocs serve
```
Once started, navigate to http://127.0.0.1:8000 to view/test locally.

**Build/Deploy instructions for Jiggle user guide**

Jiggle user guide is developed using MkDocs (https://www.mkdocs.org/) and is built and hosted using Gitlab Pages.

Official location for documentation: https://aqms-swg.gitlab.io/jiggle-userdocs/

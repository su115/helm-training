#!/bin/bash

CHART_PATH=nginx-chart

VERSION=$(awk -F': *' '/^version/ {print $2}' $CHART_PATH/Chart.yaml)
IFS='.' read MAJOR MINOR PATCH <<< "$VERSION"

export MAJOR MINOR PATCH

OLD_VERSION_LINE="version: $MAJOR.$MINOR.$PATCH"
echo "OLD $OLD_VERSION_LINE"
PATCH=$((PATCH + 1))
NEW_VERSION_LINE="version: $MAJOR.$MINOR.$PATCH"
echo "NEW $NEW_VERSION_LINE"




git status -uall
read -p "Continue? [Y/n] " CONFIRM

if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "Confirmed"
    # Update version
    sed -i "s/$OLD_VERSION_LINE/$NEW_VERSION_LINE/" $CHART_PATH/Chart.yaml


    helm package nginx-chart --destination packages
    helm repo index packages --url https://su115.github.io/helm-training/packages

    git add $CHART_PATH/
    git commit -m "update Chart $CHART_PATH"

    git add packages/
    git commit -m "release Chart v$MAJOR.$MINOR.$PATCH"
    git tag "v$MAJOR.$MINOR.$PATCH"

    git push origin master
    
    sleep 5
    helm update
else
    echo "Cancelled"
fi

#!/bin/sh

query=$1
extralines=${2-10}
cachedir=$HOME/.local/cache/rpm_filelists

mkdir -p $cachedir
cd $cachedir

if [ "$query" = "" ]; then
    for repofile in /etc/zypp/repos.d/download.opensuse.org*.repo ; do
        repo=${repofile##*/}
        repo=${repo%.*}
        repoxml=/var/cache/zypp/raw/$repo/repodata/repomd.xml
        if [ -f $repoxml ]; then
            url=$(grep baseurl $repofile | cut -d'=' -f2)$(grep -o 'repodata.*filelists.xml.gz' $repoxml)
            wget $url -O ${repo}.xml.gz
        fi
        echo
    done

    gunzip -f *.gz
else
    grep -A $extralines -B $extralines "${query}<" *.xml | grep -E "${query}|<package"
fi

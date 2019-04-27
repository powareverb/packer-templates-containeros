#!/bin/sh

cd /home/core/install

mkdir -p /opt/datalust/seq
tar zxf ./seqcli.tar.gz -C /opt/datalust/seq

echo "alias seqcli='/opt/datalust/seq/seqcli'" >> /home/core/.bashrc



#!/bin/bash

set -e

patch_java_runtime()
{
  if ! grep -q 'patch-module=java.base=ghostfucker_utils.jar' $1; then
    echo "--patch-module=java.base=ghostfucker_utils.jar" >>$1
  fi
  if ! grep -q 'add-exports=java.base/sun.net.www.protocol=ALL-UNNAMED' $1; then
    echo "--add-exports=java.base/sun.net.www.protocol=ALL-UNNAMED" >>$1
  fi
  if ! grep -q 'add-exports=java.base/sun.net.www.protocol.http=ALL-UNNAMED' $1; then
    echo "--add-exports=java.base/sun.net.www.protocol.http=ALL-UNNAMED" >>$1
  fi
  if ! grep -q 'add-exports=java.base/sun.net.www.protocol.https=ALL-UNNAMED' $1; then
    echo "--add-exports=java.base/sun.net.www.protocol.https=ALL-UNNAMED" >>$1
  fi
  if ! grep -q 'add-opens=java.base/java.net=ALL-UNNAMED' $1; then
    echo "--add-opens=java.base/java.net=ALL-UNNAMED" >>$1
  fi
  if ! grep -q 'org.glassfish.jaxb.runtime.v2.bytecode.ClassTailor.noOptimize=true' $1; then
    echo "-Dorg.glassfish.jaxb.runtime.v2.bytecode.ClassTailor.noOptimize=true" >>$1
  fi
  echo >>$1
}

# Install Extreme Mod
cd /opt/biglybt
unzip -o /app/BiglyBT_3.8.0.2_20250314.zip

# Adjust JavaVM runtime @ ${HOME}/.biglybt/java.vmoptions
patch_java_runtime "${HOME}/.biglybt/java.vmoptions"

# Adjust JavaVM runtime @ /opt/biglybt/java.vmoptions
patch_java_runtime "/opt/biglybt/java.vmoptions"

# Install extra plugins
mkdir -p /app/plugins/azneti2phelper
if [ -x /app/plugins/azneti2phelper-linux_2.8.0.2.1.biglybt ]; then
  echo "Installing /app/plugins/azneti2phelper-linux_2.8.0.2.1.biglybt..."
  unzip /app/plugins/azneti2phelper-linux_2.8.0.2.1.biglybt -d /app/plugins/azneti2phelper
else
  wget https://files.biglybt.com/plugins/azneti2phelper-linux_2.8.0.2.1.biglybt -O /app/plugins/azneti2phelper-linux_2.8.0.2.1.biglybt
  unzip /app/plugins/azneti2phelper-linux_2.8.0.2.1.biglybt -d /app/plugins/azneti2phelper
fi

mkdir -p /app/plugins/xmwebui
if [ -x /app/plugins/xmwebui_1.0.9.biglybt ]; then
  echo "Installing /app/plugins/xmwebui_1.0.9.biglybt..."
  unzip /app/plugins/xmwebui_1.0.9.biglybt -d /app/plugins/xmwebui
else
  wget https://files.biglybt.com/plugins/xmwebui_1.0.9.biglybt -O /app/plugins/xmwebui_1.0.9.biglybt
  unzip /app/plugins/xmwebui_1.0.9.biglybt -d /app/plugins/xmwebui
fi

mkdir -p /app/plugins/aznettor
if [ -x /app/plugins/aznettor-linux_1.3.8.biglybt ]; then
  echo "Installing /app/plugins/aznettor-linux_1.3.8.biglybt..."
  unzip /app/plugins/aznettor-linux_1.3.8.biglybt -d /app/plugins/aznettor
else
  wget https://files.biglybt.com/plugins/aznettor-linux_1.3.8.biglybt -O /app/plugins/aznettor-linux_1.3.8.biglybt
  unzip /app/plugins/aznettor-linux_1.3.8.biglybt -d /app/plugins/aznettor
fi

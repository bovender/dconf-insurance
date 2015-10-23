#!/bin/bash
# dconf-insurance.sh
# Backup and restore the dconf user database.
# Copyright 2015 Daniel Kraus <https://github.com/bovender>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Path to the user configuration database
# DCONF_DIR=~/.config/dconf
DCONF_DIR=~/tmp
DCONF_FILE=user
DCONF_PATH="${DCONF_DIR}/${DCONF_FILE}"

# Number of days to keep backups
KEEP_DAYS=7

# Backup and restore suffixes
BACKUP_SUFFIX=.backup-
RESTORE_SUFFIX=.restore-

# Current time stamp
TIMESTAMP=$(date +%F-%H-%m-%S)

function backup() {
        echo "Backing up dconf user database..."
        cp "$DCONF_PATH" "${DCONF_PATH}${BACKUP_SUFFIX}${TIMESTAMP}"

        # Delete old backups
        find "$DCONF_DIR" -name "${DCONF_FILE}${BACKUP_SUFFIX}\*" -mtime +$KEEP_DAYS -delete
}

function restore() {
        echo "Restoring most recent backup..."
        cp "$DCONF_PATH" "${DCONF_PATH}${RESTORE_SUFFIX}${TIMESTAMP}"
        RECENT=$(ls -c ${DCONF_PATH}${BACKUP_SUFFIX}* 2>/dev/null | head -n 1)
        if [[ ! -z $RECENT ]]; then
                cp "${RECENT}" "$DCONF_PATH"
        else
                echo "Did not find a backup to restore."
        fi
}

if [[ $1 == "-r" ]]; then
        restore
else
        backup
fi

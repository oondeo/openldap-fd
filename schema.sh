#!/bin/bash    
    sleep 10;
    echo "Prepare functiondirectory schemas"
    fusiondirectory-insert-schema;
    fusiondirectory-insert-schema --insert \
            /etc/ldap/schema/fusiondirectory/mail-fd.schema \
            /etc/ldap/schema/fusiondirectory/mail-fd-conf.schema \
            /etc/ldap/schema/fusiondirectory/systems-fd.schema \
            /etc/ldap/schema/fusiondirectory/service-fd.schema \
            /etc/ldap/schema/fusiondirectory/systems-fd-conf.schema    

    if [[ -n "$SLAPD_ADDITIONAL_FD_SCHEMAS" ]]; then
        IFS=","; declare -a schemas=($SLAPD_ADDITIONAL_FD_SCHEMAS)

        for schema in "${schemas[@]}"; do
            slapadd -n0 -F /etc/ldap/slapd.d -l "/etc/ldap/schema/fusiondirectory/${schema}.ldif" >/dev/null 2>&1
        done
    fi

    if [[ -n "$SLAPD_ADDITIONAL_SCHEMAS" ]]; then
        IFS=","; declare -a schemas=($SLAPD_ADDITIONAL_SCHEMAS)

        for schema in "${schemas[@]}"; do
            slapadd -n0 -F /etc/ldap/slapd.d -l "/etc/ldap/schema/${schema}.ldif" >/dev/null 2>&1
        done
    fi
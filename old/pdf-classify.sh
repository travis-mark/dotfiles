#!/usr/bin/env bash

DRY_RUN=0

if ! command -v pdfgrep &> /dev/null; then
    echo "pdfgrep could not be found ... trying to install"
    if ! command -v brew &> /dev/null; then
        echo "brew ... not found"
        exit
    elif ! brew install pdfgrep; then
        echo "ERROR: brew install failed"
        exit
    fi
fi

for i in $@; do
    # UGI Gas Bill
    if pdfgrep -q "UGI Utilities" "$i" &> /dev/null; then
        echo "$i :: gas bill"
        TARGET=`pdfgrep -o -e "Amount due as of (../../....)" "$i" | sed -E 's|.*([0-9]{2})/([0-9]{2})/([0-9]{4}).*|\3-\1-\2-ugi-gas-bill.pdf|g'`
        if [[ $DRY_RUN -gt 0 ]]; then
            echo "mv $i $TARGET"
        else
            mv "$i" "$TARGET"
        fi
    # Capital Region Water
    elif pdfgrep -q "Capital Region Water" "$i" &> /dev/null; then
        echo "$i :: water bill"
        TARGET=`pdfgrep -o -e "BILLING DATE.*(../../....)" "$i" | head -n 1 | sed -E 's|.*([0-9]{2})/([0-9]{2})/([0-9]{4}).*|\3-\1-\2-capital-region-water-bill.pdf|g'`
        if [[ $DRY_RUN -gt 0 ]]; then
            echo "mv $i $TARGET"
        else
            mv "$i" "$TARGET"
        fi
    elif pdfgrep -q "PPL Electric Utilities" "$i" &> /dev/null; then
	echo "$i :: electric bill"
    else
        echo "$i :: unknown"
    fi
done

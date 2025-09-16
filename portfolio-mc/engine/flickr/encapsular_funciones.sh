#!/bin/bash
# Encapsula funciones PortfolioMC_Flickr_ como métodos de la clase PortfolioMC_FlickrPlatform

ARCHIVO="FlickrPlatform.php"
BACKUP="${ARCHIVO}.bak"

cp "$ARCHIVO" "$BACKUP"

# Extraer funciones globales y prepararlas como métodos
awk '
BEGIN {in_func=0; func_code=""; }
/function[ \t]+PortfolioMC_Flickr_[a-zA-Z0-9_]+\(/ {
    in_func=1;
    sub(/function[ \t]+PortfolioMC_Flickr_/, "public function ");
    sub(/\(/, "(", $0);
    func_code=func_code "\n    " $0 "\n";
    next;
}
in_func && /{/ {
    func_code=func_code "    " $0 "\n";
    next;
}
in_func && /}/ {
    func_code=func_code "    " $0 "\n";
    in_func=0;
    next;
}
in_func {
    func_code=func_code "    " $0 "\n";
    next;
}
!in_func {
    print $0;
}
END {
    print "__PORTFOLIOMC_METHODS_PLACEHOLDER__";
    print func_code;
}
' "$BACKUP" > "${ARCHIVO}.tmp"

# Insertar los métodos dentro de la clase PortfolioMC_FlickrPlatform
awk '
/class[ \t]+PortfolioMC_FlickrPlatform[ \t]*\{/ {
    print;
    print "    // Métodos migrados automáticamente:";
    in_class=1;
    next;
}
in_class && /}/ {
    print "__PORTFOLIOMC_ENDCLASS_PLACEHOLDER__";
    in_class=0;
}
{
    print $0;
}
' "${ARCHIVO}.tmp" > "${ARCHIVO}.tmp2"

# Remover funciones globales y agregar los métodos dentro de la clase
sed -e '/__PORTFOLIOMC_METHODS_PLACEHOLDER__/d' \
    -e '/__PORTFOLIOMC_ENDCLASS_PLACEHOLDER__/r /dev/stdin' \
    -e '/__PORTFOLIOMC_ENDCLASS_PLACEHOLDER__/d' \
    "${ARCHIVO}.tmp2" < <(awk '/__PORTFOLIOMC_METHODS_PLACEHOLDER__/ {flag=1;next} flag{print} END{flag=0}' "${ARCHIVO}.tmp") > "$ARCHIVO"

rm "${ARCHIVO}.tmp" "${ARCHIVO}.tmp2"

echo "✔️ Funciones migradas dentro de la clase PortfolioMC_FlickrPlatform."
echo "Backup creado en $BACKUP"
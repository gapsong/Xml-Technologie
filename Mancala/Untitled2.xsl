<?xml version="1.0"?>

<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/2000/svg"
    >
    <xsl:output
        method="xml"
        indent="yes"
        standalone="no"
        doctype-public="-//W3C//DTD SVG 1.1//EN"
        doctype-system="http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"
        media-type="image/svg" />
    
    <xsl:template match="thing">
        <svg xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            width="100%" height="100%" viewBox="0 0 1200 600" preserveAspectRatio="xMidYMid meet">
                       
            <svg>
                
                <text x="50%" y="50%" font-size="50" font-family="monospace" fill="orange" text-anchor="middle" > <xsl:value-of select="spielfeld/mulde/@besitzer"/> </text>
            </svg>
            
           
        </svg>
    </xsl:template>
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>

<!--  Dyatlova, Yekaterina, Tadevosyan, Hasmik, Arhuata Meza, Carla -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" doctype-system="about:legacy-compat" omit-xml-declaration="yes"
        encoding="UTF-8" indent="yes"/>


    <xsl:template match="/">

        <!-- SVG Spielfeld-->
        <!-- Einbinden von SVG und xLink -->
        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
            width="100%" height="100%">

            <!-- Definition der wiederverwendbaren Elemente -->
            <defs>

                <!--  -->
                <g id="mancala-grundgeruest">
                    <!-- Hintergrund -->
                    <rect x="20" y="360" width="300" height="100"
                        style="stroke:#006600; fill: #778899"/>

                    <!-- Spielbrett -->
                    <rect x="0" y="0" width="1000" height="300"
                        style="stroke:#006600; fill: #deb887"/>

                    <xsl:for-each select="spielMancala/grube">
                        <xsl:variable name="numSteine" select="concat('#', count(stein), '_stein')"/>
                        <xsl:variable name="xCor" select="@xCor"/>
                        <xsl:variable name="yCor" select="@yCor"/>
                        <xsl:if test="@type = 'mulde'">
                            <circle cx="{$xCor}" cy="{$yCor}" r="50"
                                style="stroke:#006600; fill: #a0522d"/>
                        </xsl:if>
                        <xsl:if test="@type = 'kalaha'">
                            <ellipse cx="{$xCor}" cy="{$yCor}" rx="60" ry="120"
                                style="stroke:#006600; fill: #a0522d"/>
                        </xsl:if>

                    </xsl:for-each>

                    <!-- Steine hier pro Grube plazieren, damit die Koordinaten relativ zum Spielbrett sind -->
                    <xsl:for-each select="spielMancala/grube">
                        <xsl:variable name="numSteine" select="concat('#', count(stein), '_stein')"/>
                        <xsl:variable name="xCor" select="@xCor"/>
                        <xsl:variable name="yCor" select="@yCor"/>
                        
                        <!-- Setzt den Stein Counter in Rechtecke -->
                        <xsl:choose>
                            <xsl:when test="@gehörtZuSpieler=1">
                                <xsl:if test="@type='kalaha'">
                                    <rect width="30" height="20"  x="{$xCor - 15}" y="{$yCor - 145}" style="fill:rgb(255,255,255);stroke-width:1;stroke:rgb(0,0,0)"> </rect>
                                    <text x="{$xCor - 10}" y="{$yCor - 130}" fill="black" > 
                                        <xsl:value-of select="count(stein)"/>
                                    </text>
                                    <text x="{$xCor - 30}" y="{$yCor + 140}" style="fill: #000000; stroke: none; font-weight: bold">
                                        Spieler 1
                                    </text>
                                </xsl:if>
                                <xsl:if test="@type='mulde'">
                                    <rect width="30" height="20"  x="{$xCor - 15}" y="{$yCor -75}" style="fill:rgb(255, 255, 255);stroke-width:1;stroke:rgb(0,0,0)"></rect>
                                    <text x="{$xCor - 10}" y="{$yCor - 60}" fill="black" > 
                                        <xsl:value-of select="count(stein)"/>
                                    </text>
                                </xsl:if>
                            </xsl:when>
                            <xsl:when test="@gehörtZuSpieler=2">
                                <xsl:if test="@type='kalaha'">
                                    <rect width="30" height="20"  x="{$xCor - 15}" y="{$yCor + 125}" style="fill:rgb(255,255,255);stroke-width:1;stroke:rgb(0,0,0)"></rect>
                                    <text x="{$xCor - 10}" y="{$yCor + 140}" fill="black" > 
                                        <xsl:value-of select="count(stein)"/>
                                    </text>
                                    <text x="{$xCor - 30}" y="{$yCor - 130}" style="fill: #000000; stroke: none; font-weight: bold">
                                        Spieler 2
                                    </text>
                                </xsl:if>
                                <xsl:if test="@type='mulde'">
                                    <rect width="30" height="20"  x="{$xCor - 15}" y="{$yCor + 55}" style="fill:rgb(255,255,255);stroke-width:1;stroke:rgb(0,0,0)"></rect>
                                    <text x="{$xCor - 10}" y="{$yCor + 70}" fill="black" > 
                                        <xsl:value-of select="count(stein)"/>
                                    </text>
                                </xsl:if>
                            </xsl:when>
                        </xsl:choose>
                        
                        <!-- Plaziert die Steine -->
                        <use xlink:href="{$numSteine}" x="{$xCor}" y="{$yCor}"/>
                    </xsl:for-each>
          
                    <!-- Anzeige, wer am Zug ist -->
                    
                    <xsl:choose>
                        <xsl:when test="not(spielMancala/spiel/@gewinner='')">
                            <text x="40" y="420" style="fill: #000000; stroke: none; font-size: 24px;">
                                <xsl:value-of select="concat(spielMancala/spiel/@gewinner, ' hat gewonnen')"/>
                            </text>
                        </xsl:when>
                        <xsl:when test="spielMancala/spiel/@istAmZugSpieler1 = 'true'">
                            <text x="40" y="420"
                                style="fill: #000000; stroke: none; font-size: 24px;"> Dein Zug
                                Spieler 1 </text>
                        </xsl:when>
                        <xsl:otherwise>
                            <text x="40" y="420"
                                style="fill: #000000; stroke: none; font-size: 24px;"> Dein Zug
                                Spieler 2 </text>
                        </xsl:otherwise>
                    </xsl:choose>

                </g>
                
                <!-- Devinition des Aussehens von unterschiedlichen Steinanzahlen -->

                <!-- Bei einem Stein -->
                <g id="1_stein">
                    <circle r="10" style="stroke:#006600; fill: #0000ff;"/>
                </g>
                <!-- Bei zwei Steinen -->
                <g id="2_stein">
                    <use xlink:href="#1_stein" x="-20" y="-20"/>
                    <use xlink:href="#1_stein" x="20" y="20"/>
                </g>

                <!-- Bei zwei Steinen -->
                <g id="3_stein">
                    <use xlink:href="#1_stein" x="-20" y="-20"/>
                    <use xlink:href="#1_stein" x="20" y="20"/>
                    <use xlink:href="#1_stein" x="-20" y="20"/>
                </g>

                <!-- Bei vier Steinen -->
                <g id="4_stein">
                    <use xlink:href="#1_stein" x="-20" y="-20"/>
                    <use xlink:href="#1_stein" x="20" y="20"/>
                    <use xlink:href="#1_stein" x="-20" y="20"/>
                    <use xlink:href="#1_stein" x="20" y="-20"/>
                </g>

                <g id="5_stein">
                    <use xlink:href="#1_stein" x="-20" y="-20"/>
                    <use xlink:href="#1_stein" x="-20" y="20"/>
                    <use xlink:href="#1_stein" x="20" y="-20"/>
                    <use xlink:href="#1_stein" x="20" y="20"/>
                    <use xlink:href="#1_stein" x="0" y="0"/>
                </g>

                <g id="6_stein">
                    <use xlink:href="#1_stein" x="-15" y="-25"/>
                    <use xlink:href="#1_stein" x="-15" y="25"/>
                    <use xlink:href="#1_stein" x="15" y="-25"/>
                    <use xlink:href="#1_stein" x="15" y="25"/>
                    <use xlink:href="#1_stein" x="30" y="0"/>
                    <use xlink:href="#1_stein" x="-30" y="0"/>
                </g>

                <g id="7_stein">
                    <use xlink:href="#6_stein"/>
                    <use xlink:href="#1_stein" x="0" y="0"/>
                </g>

                <g id="8_stein">
                    <use xlink:href="#7_stein"/>
                    <use xlink:href="#1_stein" x="0" y="-40"/>
                </g>

                <g id="9_stein">
                    <use xlink:href="#8_stein"/>
                    <use xlink:href="#1_stein" x="0" y="40"/>
                </g>

                <g id="10_stein">
                    <use xlink:href="#9_stein"/>
                    <use xlink:href="#1_stein" x="-35" y="-20"/>
                </g>

                <g id="11_stein">
                    <use xlink:href="#10_stein"/>
                    <use xlink:href="#1_stein" x="-35" y="20"/>
                </g>

                <g id="12_stein">
                    <use xlink:href="#11_stein"/>
                    <use xlink:href="#1_stein" x="35" y="-20"/>
                </g>

                <g id="13_stein">
                    <use xlink:href="#12_stein"/>
                    <use xlink:href="#1_stein" x="35" y="20"/>
                </g>

                <g id="14_stein">
                    <use xlink:href="#13_stein"/>
                    <use xlink:href="#1_stein" x="-50" y="0"/>
                </g>

                <g id="15_stein">
                    <use xlink:href="#14_stein"/>
                    <use xlink:href="#1_stein" x="50" y="0"/>
                </g>

                <g id="16_stein">
                    <use xlink:href="#15_stein"/>
                    <use xlink:href="#1_stein" x="-15" y="-45"/>
                </g>

                <g id="17_stein">
                    <use xlink:href="#16_stein"/>
                    <use xlink:href="#1_stein" x="15" y="-45"/>
                </g>

                <g id="18_stein">
                    <use xlink:href="#17_stein"/>
                    <use xlink:href="#1_stein" x="-15" y="-65"/>
                </g>

                <g id="19_stein">
                    <use xlink:href="#18_stein"/>
                    <use xlink:href="#1_stein" x="15" y="-65"/>
                </g>

                <g id="20_stein">
                    <use xlink:href="#19_stein"/>
                    <use xlink:href="#1_stein" x="-15" y="-85"/>
                </g>

                <g id="21_stein">
                    <use xlink:href="#20_stein"/>
                    <use xlink:href="#1_stein" x="15" y="-85"/>
                </g>

                <g id="22_stein">
                    <use xlink:href="#21_stein"/>
                    <use xlink:href="#1_stein" x="-15" y="-105"/>
                </g>

                <g id="23_stein">
                    <use xlink:href="#22_stein"/>
                    <use xlink:href="#1_stein" x="15" y="-105"/>
                </g>

                <g id="24_stein">
                    <use xlink:href="#23_stein"/>
                    <use xlink:href="#1_stein" x="-15" y="45"/>
                </g>

                <g id="25_stein">
                    <use xlink:href="#24_stein"/>
                    <use xlink:href="#1_stein" x="15" y="45"/>
                </g>

                <g id="26_stein">
                    <use xlink:href="#25_stein"/>
                    <use xlink:href="#1_stein" x="-15" y="65"/>
                </g>

                <g id="27_stein">
                    <use xlink:href="#26_stein"/>
                    <use xlink:href="#1_stein" x="15" y="65"/>
                </g>

                <g id="28_stein">
                    <use xlink:href="#27_stein"/>
                    <use xlink:href="#1_stein" x="-15" y="85"/>
                </g>

                <g id="29_stein">
                    <use xlink:href="#28_stein"/>
                    <use xlink:href="#1_stein" x="15" y="85"/>
                </g>

                <g id="30_stein">
                    <use xlink:href="#29_stein"/>
                    <use xlink:href="#1_stein" x="-15" y="105"/>
                </g>

                <g id="31_stein">
                    <use xlink:href="#30_stein"/>
                    <use xlink:href="#1_stein" x="15" y="105"/>
                </g>

                <g id="31_stein">
                    <use xlink:href="#30_stein"/>
                    <use xlink:href="#1_stein" x="15" y="105"/>
                </g>

                <g id="32_stein">
                    <use xlink:href="#31_stein"/>
                    <use xlink:href="#1_stein" x="0" y="120"/>
                </g>

            </defs>
                
            <!-- Instanzizierung des gesamten Spiels -->
            <text x="50" y="100" style="fill: #000000; stroke: none; font-size: 50px;">
                Let's play Mancala
            </text>
            <use xlink:href="#mancala-grundgeruest" x="50" y="150"/>

        </svg>
    </xsl:template>
</xsl:stylesheet>



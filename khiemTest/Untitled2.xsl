<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/2000/svg">

    <xsl:output method="xml" indent="yes" standalone="no" doctype-public="-//W3C//DTD SVG 1.1//EN" doctype-system="http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd" media-type="image/svg"/>

    <xsl:template match="spielfeld">
        <svg width="1200" height="600" xmlns="http://www.w3.org/2000/svg"
          xmlns:xlink="http://www.w3.org/1999/xlink">
          <defs>
              <!-- Red glow, that marks the players turn -->
              <filter id="glow">
                  <feColorMatrix type="matrix" values=
                      "0 0 0 1 0
                       0 0 0 0 0
                       0 0 0 0 0
                       0 0 0 1 0"/>
                  <feGaussianBlur stdDeviation="6" result="coloredBlur"/>
                  <feMerge>
                      <feMergeNode in="coloredBlur"/>
                      <feMergeNode in="SourceGraphic"/>
                  </feMerge>
              </filter>
              <!-- Store -->
              <ellipse id="store" rx="6%" ry="29%" stroke-width="0.3%" />
              <!-- Hole of player 1 -->
              <rect id="hole-p1" rx="20" ry="20" y="10.5%" height="18%" width="9%" stroke="orange" stroke-width="0.3%" fill="white" style="filter:url(#glow)" />
              <!-- Hole of player 2-->
              <rect id="hole-p2" rx="20" ry="20" y="45.5%" height="18%" width="9%" stroke="blue" stroke-width="0.3%" fill="white" />
              <!-- Button -->
              <rect id="button" y="85%" rx="20" ry="20" width="15%" height="6%" stroke="green" stroke-width="0.3%" fill="green"  />
          </defs>

          <!-- The board -->
          <svg>
              <rect rx="20" ry="20" x="2%" width="96%" height="75%" fill="lightblue" stroke="grey" stroke-width="3" fill-opacity="1"/>
          </svg>

          <!-- shows which player is on turn or which player won -->
          <svg>
              <text x="50%" y="39.5%" font-size="50" font-family="monospace" fill="orange" text-anchor="middle" >Player 1's turn</text>
          </svg>

          <!-- Store of player 1 -->
          <use id="store-p1" xlink:href="#store" x="9%" y="37%" stroke="orange" fill="white" style="filter:url(#glow)" />
           <!-- Store of player 2 -->
          <use id="store-p2" xlink:href="#store" x="91%" y="37%" stroke="blue" fill="white" />

          <!-- Holes of Player 1-->
          <use id="hole-p1-1" xlink:href="#hole-p1" x="15.5%" />
          <use id="hole-p1-2" xlink:href="#hole-p1" x="27.5%" />
          <use id="hole-p1-3" xlink:href="#hole-p1" x="39.5%" />
          <use id="hole-p1-4" xlink:href="#hole-p1" x="51.5%" />
          <use id="hole-p1-5" xlink:href="#hole-p1" x="63.5%" />
          <use id="hole-p1-6" xlink:href="#hole-p1" x="75.5%" />
          <!-- Holes of Player 2-->
          <use id="hole-p2-1" xlink:href="#hole-p2" x="15.5%" />
          <use id="hole-p2-2" xlink:href="#hole-p2" x="27.5%" />
          <use id="hole-p2-3" xlink:href="#hole-p2" x="39.5%" />
          <use id="hole-p2-4" xlink:href="#hole-p2" x="51.5%" />
          <use id="hole-p2-5" xlink:href="#hole-p2" x="63.5%" />
          <use id="hole-p2-6" xlink:href="#hole-p2" x="75.5%" />

          <!-- Anzahl der Kugeln in einer Mulde -->
          <svg>
              <text x="15.5%"  y="10.5%" font-size="50" font-family="monospace" fill="orange" text-anchor="middle" >
                <xsl:value-of select="mulde[1]/anzahlSteine" />
              </text>
          </svg>

          <!-- Score of player 1 -->
          <svg id="store-p1-score">
              <text x="9%" y="40%" font-size="60" font-family="monospace" fill="orange" text-anchor="middle" >
                  <xsl:value-of select="haus[1]/anzahlSteineimHaus"/>
              </text>
          </svg>
          <!-- Score of player 2 -->
          <svg id="store-p2-score">
              <text x="91%" y="40%" font-size="60" font-family="monospace" fill="blue" text-anchor="middle" >
                  <xsl:value-of select="haus[2]/anzahlSteineimHaus"/>
              </text>
          </svg>


        </svg>
    </xsl:template>
</xsl:stylesheet>


<!-- <svg id="store-p2-score">
      <text x="91%" y="40%" font-size="60" font-family="monospace" fill="blue" text-anchor="middle">
          <xsl:value-of select="mulde[2]/anzahlSteine"/>
      </text>
  </svg> -->

{vars, ...}: let
  replaceFont = fontName: ''
    <match target="pattern">
        <test qual="any" name="family"><string>${fontName}</string></test>
        <edit name="family" mode="assign" binding="same"><string>JoyPixels</string></edit>
    </match>
  '';
in
  with vars; {
    xdg.configFile."fontconfig/fonts.conf".text = ''
       <fontconfig>
        <match target="pattern">
       	<test name="family" qual="any">
       		<string>monospace</string>
       	</test>
       	<edit binding="strong" mode="prepend" name="family">
       		<string>${mono_font}</string>
       	</edit>
       </match>
       <match target="pattern">
       	<test name="family" qual="any">
       		<string>sans-serif</string>
       	</test>
       	<edit binding="strong" mode="prepend" name="family">
       		<string>${sans_font}</string>
       	</edit>
       </match>
       <match target="pattern">
       	<test name="family" qual="any">
       		<string>serif</string>
       	</test>
       	<edit binding="strong" mode="prepend" name="family">
       		<string>${serif_font}</string>
       	</edit>
       </match>

      <match target="pattern">
          <test qual="any" name="family"><string>emoji</string></test>
          <edit name="family" mode="assign" binding="same"><string>JoyPixels</string></edit>
      </match>


      <match target="pattern">
          <test name="family"><string>sans</string></test>
          <edit name="family" mode="append"><string>JoyPixels</string></edit>
      </match>

      <match target="pattern">
          <test name="family"><string>serif</string></test>
          <edit name="family" mode="append"><string>JoyPixels</string></edit>
      </match>

      <match target="pattern">
          <test name="family"><string>sans-serif</string></test>
          <edit name="family" mode="append"><string>JoyPixels</string></edit>
      </match>

      <match target="pattern">
          <test name="family"><string>monospace</string></test>
          <edit name="family" mode="append"><string>JoyPixels</string></edit>
      </match>

       <selectfont>
           <rejectfont>
                 <pattern>
                     <patelt name="family">
                         <string>Symbola</string>
                     </patelt>
                 </pattern>
             </rejectfont>
       </selectfont>

       ${toString (map (x: replaceFont x) [
        "Apple Color Emoji"
        "Segoe UI Emoji"
        "Segoe UI Symbol"
        "Android Emoji"
        "Twitter Color Emoji"
        "Twemoji"
        "Twemoji Mozilla"
        "TwemojiMozilla"
        "Emoji Two"
        "EmojiTwo"
        "EmojiSymbols"
        "Symbola"
      ])}

       <match target="font">
         <edit name="rgba" mode="assign">
           <const>rgb</const>
         </edit>
         <edit name="hinting" mode="assign">
           <bool>true</bool>
         </edit>
         <edit name="hintstyle" mode="assign">
           <const>hintslight</const>
         </edit>
         <edit name="antialias" mode="assign">
           <bool>true</bool>
         </edit>
         <edit name="lcdfilter" mode="assign">
           <const>lcddefault</const>
         </edit>
       </match>
       </fontconfig>
    '';
  }

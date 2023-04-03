{vars, ...}:
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

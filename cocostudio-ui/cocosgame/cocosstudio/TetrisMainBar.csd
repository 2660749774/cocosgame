<GameFile>
  <PropertyGroup Name="TetrisMainBar" Type="Scene" ID="c97ee6ec-f743-428e-9f04-71c0a28adb8f" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene" Tag="24" ctype="GameNodeObjectData">
        <Size X="640.0000" Y="1136.0000" />
        <Children>
          <AbstractNodeData Name="panel" ActionTag="1918327196" Tag="34" IconVisible="False" TopMargin="0.0002" BottomMargin="-0.0002" ClipAble="False" ColorAngle="90.0000" LeftEage="131" RightEage="131" TopEage="288" BottomEage="288" Scale9OriginX="-131" Scale9OriginY="-288" Scale9Width="262" Scale9Height="576" ctype="PanelObjectData">
            <Size X="640.0000" Y="1136.0000" />
            <Children>
              <AbstractNodeData Name="bar_bg" ActionTag="-940487486" Tag="603" IconVisible="False" LeftMargin="-1.3576" RightMargin="1.3576" TopMargin="-5.9991" BottomMargin="1045.9991" Scale9Enable="True" LeftEage="50" RightEage="50" Scale9OriginX="50" Scale9Width="50" Scale9Height="96" ctype="ImageViewObjectData">
                <Size X="640.0000" Y="96.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="318.6424" Y="1093.9991" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4979" Y="0.9630" />
                <PreSize X="1.0000" Y="0.0845" />
                <FileData Type="Normal" Path="ui/tetris/power/main_bar_bg.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="energy_bg_3" ActionTag="93165302" Tag="605" IconVisible="False" LeftMargin="22.0222" RightMargin="381.9778" TopMargin="13.0000" BottomMargin="1063.0000" ctype="SpriteObjectData">
                <Size X="236.0000" Y="60.0000" />
                <Children>
                  <AbstractNodeData Name="lb_energy" ActionTag="342081876" Tag="607" IconVisible="False" LeftMargin="97.9890" RightMargin="68.0110" TopMargin="15.0000" BottomMargin="17.0000" FontSize="28" LabelText="10000" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                    <Size X="70.0000" Y="28.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="132.9890" Y="31.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5635" Y="0.5167" />
                    <PreSize X="0.2966" Y="0.4667" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="34" G="93" B="104" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="btn_buy_energy" ActionTag="-1020333601" Tag="609" IconVisible="False" LeftMargin="217.8605" RightMargin="-26.8605" TopMargin="6.1960" BottomMargin="8.8040" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="15" Scale9Height="23" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                    <Size X="45.0000" Y="45.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="240.3605" Y="31.3040" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="1.0185" Y="0.5217" />
                    <PreSize X="0.1907" Y="0.7500" />
                    <TextColor A="255" R="65" G="65" B="70" />
                    <DisabledFileData Type="Normal" Path="ui/tetris/power/pay_bg.png" Plist="" />
                    <PressedFileData Type="Normal" Path="ui/tetris/power/pay_bg.png" Plist="" />
                    <NormalFileData Type="Normal" Path="ui/tetris/power/pay_bg.png" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="140.0222" Y="1093.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.2188" Y="0.9621" />
                <PreSize X="0.3688" Y="0.0528" />
                <FileData Type="Normal" Path="ui/tetris/power/energy_bg.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="item_bg_2" ActionTag="1993350574" Tag="604" IconVisible="False" LeftMargin="349.6490" RightMargin="54.3510" TopMargin="13.0000" BottomMargin="1063.0000" ctype="SpriteObjectData">
                <Size X="236.0000" Y="60.0000" />
                <Children>
                  <AbstractNodeData Name="lb_item" ActionTag="-11269108" Tag="608" IconVisible="False" LeftMargin="100.9896" RightMargin="65.0104" TopMargin="15.0000" BottomMargin="17.0000" FontSize="28" LabelText="10000" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                    <Size X="70.0000" Y="28.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="135.9896" Y="31.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5762" Y="0.5167" />
                    <PreSize X="0.2966" Y="0.4667" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="34" G="93" B="104" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="btn_buy_item" ActionTag="185482205" Tag="606" IconVisible="False" LeftMargin="218.8602" RightMargin="-27.8602" TopMargin="6.1962" BottomMargin="8.8038" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="15" Scale9Height="23" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                    <Size X="45.0000" Y="45.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="241.3602" Y="31.3038" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="1.0227" Y="0.5217" />
                    <PreSize X="0.1907" Y="0.7500" />
                    <TextColor A="255" R="65" G="65" B="70" />
                    <DisabledFileData Type="Normal" Path="ui/tetris/power/pay_bg.png" Plist="" />
                    <PressedFileData Type="Normal" Path="ui/tetris/power/pay_bg.png" Plist="" />
                    <NormalFileData Type="Normal" Path="ui/tetris/power/pay_bg.png" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="467.6490" Y="1093.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.7307" Y="0.9621" />
                <PreSize X="0.3688" Y="0.0528" />
                <FileData Type="Normal" Path="ui/tetris/power/item_bg.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="bottom_bg" ActionTag="-631001238" Tag="306" IconVisible="False" LeftMargin="-106.0000" RightMargin="-106.0000" TopMargin="1036.0000" ctype="SpriteObjectData">
                <Size X="852.0000" Y="100.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="50.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.0440" />
                <PreSize X="1.3312" Y="0.0880" />
                <FileData Type="Normal" Path="ui/tetris/power/bar_bg.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="bar1" ActionTag="966073418" Tag="307" IconVisible="False" RightMargin="475.0000" TopMargin="1036.0000" ctype="SpriteObjectData">
                <Size X="165.0000" Y="100.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="82.5000" Y="50.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.1289" Y="0.0440" />
                <PreSize X="0.2578" Y="0.0880" />
                <FileData Type="Normal" Path="ui/tetris/power/bar_unchoose.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="bar2" ActionTag="1559931258" Tag="312" IconVisible="False" LeftMargin="237.5000" RightMargin="237.5000" TopMargin="1036.0000" ctype="SpriteObjectData">
                <Size X="165.0000" Y="100.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="50.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.0440" />
                <PreSize X="0.2578" Y="0.0880" />
                <FileData Type="Normal" Path="ui/tetris/power/bar_unchoose.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="bar3" ActionTag="1703063180" Tag="313" IconVisible="False" LeftMargin="475.0000" TopMargin="1036.0000" ctype="SpriteObjectData">
                <Size X="165.0000" Y="100.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="557.5000" Y="50.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8711" Y="0.0440" />
                <PreSize X="0.2578" Y="0.0880" />
                <FileData Type="Normal" Path="ui/tetris/power/bar_unchoose.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="bar_choose" ActionTag="-1289126820" Tag="315" IconVisible="False" LeftMargin="165.0000" RightMargin="165.0000" TopMargin="1036.0000" ctype="SpriteObjectData">
                <Size X="310.0000" Y="100.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="50.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.0440" />
                <PreSize X="0.4844" Y="0.0880" />
                <FileData Type="Normal" Path="ui/tetris/power/bar_choose.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="bar_light" Visible="False" ActionTag="-1143306355" Tag="314" IconVisible="False" LeftMargin="165.0000" RightMargin="165.0000" TopMargin="1036.0000" ctype="SpriteObjectData">
                <Size X="310.0000" Y="100.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="50.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.0440" />
                <PreSize X="0.4844" Y="0.0880" />
                <FileData Type="Normal" Path="ui/tetris/power/bar_light.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_left" ActionTag="-1639436447" Tag="316" IconVisible="False" LeftMargin="164.0000" RightMargin="454.0000" TopMargin="1068.0000" BottomMargin="32.0000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="7" RightEage="7" TopEage="11" BottomEage="11" Scale9OriginX="7" Scale9OriginY="11" Scale9Width="8" Scale9Height="14" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="22.0000" Y="36.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="175.0000" Y="50.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.2734" Y="0.0440" />
                <PreSize X="0.0344" Y="0.0317" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Normal" Path="ui/tetris/power/btn_arrow.png" Plist="" />
                <PressedFileData Type="Normal" Path="ui/tetris/power/btn_arrow.png" Plist="" />
                <NormalFileData Type="Normal" Path="ui/tetris/power/btn_arrow.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_right" ActionTag="241159090" Tag="317" RotationSkewX="180.0000" RotationSkewY="180.0000" IconVisible="False" LeftMargin="452.0000" RightMargin="166.0000" TopMargin="1068.0000" BottomMargin="32.0000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="7" RightEage="7" TopEage="11" BottomEage="11" Scale9OriginX="7" Scale9OriginY="11" Scale9Width="8" Scale9Height="14" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="22.0000" Y="36.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="463.0000" Y="50.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.7234" Y="0.0440" />
                <PreSize X="0.0344" Y="0.0317" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Normal" Path="ui/tetris/power/btn_arrow.png" Plist="" />
                <PressedFileData Type="Normal" Path="ui/tetris/power/btn_arrow.png" Plist="" />
                <NormalFileData Type="Normal" Path="ui/tetris/power/btn_arrow.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_intro" ActionTag="-1785680686" Tag="318" IconVisible="False" LeftMargin="290.0000" RightMargin="290.0000" TopMargin="1104.0000" BottomMargin="8.0000" FontSize="24" LabelText="副 本" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ShadowEnabled="True" ctype="TextObjectData">
                <Size X="60.0000" Y="24.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="20.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.0176" />
                <PreSize X="0.0938" Y="0.0211" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="0" G="0" B="0" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_single" ActionTag="2023771919" Tag="310" IconVisible="False" LeftMargin="268.0000" RightMargin="268.0000" TopMargin="996.0000" BottomMargin="30.0000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="74" Scale9Height="88" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="104.0000" Y="110.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="85.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.0748" />
                <PreSize X="0.1625" Y="0.0968" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Normal" Path="ui/tetris/power/btn_single.png" Plist="" />
                <PressedFileData Type="Normal" Path="ui/tetris/power/btn_single.png" Plist="" />
                <NormalFileData Type="Normal" Path="ui/tetris/power/btn_single.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_shop" ActionTag="215364878" Tag="309" IconVisible="False" LeftMargin="30.5000" RightMargin="505.5000" TopMargin="1026.0000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="74" Scale9Height="88" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="104.0000" Y="110.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="82.5000" Y="55.0000" />
                <Scale ScaleX="0.8000" ScaleY="0.8000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.1289" Y="0.0484" />
                <PreSize X="0.1625" Y="0.0968" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Normal" Path="ui/tetris/power/btn_shop.png" Plist="" />
                <PressedFileData Type="Normal" Path="ui/tetris/power/btn_shop.png" Plist="" />
                <NormalFileData Type="Normal" Path="ui/tetris/power/btn_shop.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_multi" ActionTag="-725753622" Tag="311" IconVisible="False" LeftMargin="505.5000" RightMargin="30.5000" TopMargin="1026.0000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="74" Scale9Height="88" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="104.0000" Y="110.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="557.5000" Y="55.0000" />
                <Scale ScaleX="0.8000" ScaleY="0.8000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8711" Y="0.0484" />
                <PreSize X="0.1625" Y="0.0968" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Normal" Path="ui/tetris/power/btn_multi.png" Plist="" />
                <PressedFileData Type="Normal" Path="ui/tetris/power/btn_multi.png" Plist="" />
                <NormalFileData Type="Normal" Path="ui/tetris/power/btn_multi.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="320.0000" Y="567.9998" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize X="1.0000" Y="1.0000" />
            <SingleColor A="255" R="255" G="255" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameFile>
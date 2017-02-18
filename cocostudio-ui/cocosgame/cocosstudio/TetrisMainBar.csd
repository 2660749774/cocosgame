<GameFile>
  <PropertyGroup Name="TetrisMainBar" Type="Scene" ID="c97ee6ec-f743-428e-9f04-71c0a28adb8f" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene" Tag="24" ctype="GameNodeObjectData">
        <Size X="640.0000" Y="1136.0000" />
        <Children>
          <AbstractNodeData Name="panel" ActionTag="1918327196" Tag="34" IconVisible="False" ClipAble="False" ColorAngle="90.0000" LeftEage="131" RightEage="131" TopEage="288" BottomEage="288" Scale9OriginX="-131" Scale9OriginY="-288" Scale9Width="262" Scale9Height="576" ctype="PanelObjectData">
            <Size X="640.0000" Y="1136.0000" />
            <Children>
              <AbstractNodeData Name="bar_bg" ActionTag="-940487486" Tag="603" IconVisible="False" LeftMargin="-1.3576" RightMargin="1.3575" TopMargin="-5.9991" BottomMargin="1045.9991" Scale9Enable="True" LeftEage="50" RightEage="50" Scale9OriginX="50" Scale9Width="50" Scale9Height="96" ctype="ImageViewObjectData">
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
                  <AbstractNodeData Name="lb_energy" ActionTag="342081876" Tag="607" IconVisible="False" LeftMargin="93.9890" RightMargin="64.0110" TopMargin="13.0000" BottomMargin="15.0000" FontSize="28" LabelText="10000" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                    <Size X="78.0000" Y="32.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="132.9890" Y="31.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5635" Y="0.5167" />
                    <PreSize X="0.3305" Y="0.5333" />
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
                  <AbstractNodeData Name="lb_item" ActionTag="-11269108" Tag="608" IconVisible="False" LeftMargin="96.9896" RightMargin="61.0104" TopMargin="13.0000" BottomMargin="15.0000" FontSize="28" LabelText="10000" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                    <Size X="78.0000" Y="32.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="135.9896" Y="31.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5762" Y="0.5167" />
                    <PreSize X="0.3305" Y="0.5333" />
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
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="320.0000" Y="568.0000" />
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
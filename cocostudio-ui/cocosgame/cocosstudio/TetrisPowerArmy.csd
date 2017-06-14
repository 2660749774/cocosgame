<GameFile>
  <PropertyGroup Name="TetrisPowerArmy" Type="Scene" ID="473c3a98-d3f2-4c19-a86d-76fb82112a9d" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene" Tag="80" ctype="GameNodeObjectData">
        <Size X="640.0000" Y="1136.0000" />
        <Children>
          <AbstractNodeData Name="panel" ActionTag="-1158975453" Tag="85" IconVisible="False" LeftMargin="-50.0000" RightMargin="590.0000" TopMargin="1086.0000" BottomMargin="-50.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
            <Size X="100.0000" Y="100.0000" />
            <Children>
              <AbstractNodeData Name="btn" ActionTag="1659918641" Tag="81" IconVisible="False" LeftMargin="5.2294" RightMargin="4.7706" TopMargin="-8.0181" BottomMargin="18.0181" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="60" Scale9Height="68" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="90.0000" Y="90.0000" />
                <AnchorPoint ScaleX="0.3000" ScaleY="0.5000" />
                <Position X="32.2294" Y="63.0181" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.3223" Y="0.6302" />
                <PreSize X="0.9000" Y="0.9000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="PlistSubImage" Path="power_clearstone_unopen.png" Plist="ui/plist/main.plist" />
                <PressedFileData Type="PlistSubImage" Path="power_clearstone_open.png" Plist="ui/plist/main.plist" />
                <NormalFileData Type="PlistSubImage" Path="power_clearstone_open.png" Plist="ui/plist/main.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="star1" ActionTag="-1076218770" VisibleForFrame="False" Tag="82" IconVisible="False" LeftMargin="30.9574" RightMargin="34.0426" TopMargin="67.2003" BottomMargin="-2.2003" ctype="SpriteObjectData">
                <Size X="35.0000" Y="35.0000" />
                <AnchorPoint ScaleX="0.3000" ScaleY="0.5000" />
                <Position X="41.4574" Y="15.2997" />
                <Scale ScaleX="0.8000" ScaleY="0.8000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4146" Y="0.1530" />
                <PreSize X="0.3500" Y="0.3500" />
                <FileData Type="PlistSubImage" Path="power_star.png" Plist="ui/plist/common.plist" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="star3" ActionTag="-2125964104" VisibleForFrame="False" Tag="83" IconVisible="False" LeftMargin="60.2408" RightMargin="4.7592" TopMargin="61.3655" BottomMargin="3.6345" ctype="SpriteObjectData">
                <Size X="35.0000" Y="35.0000" />
                <AnchorPoint ScaleX="0.3000" ScaleY="0.5000" />
                <Position X="70.7408" Y="21.1345" />
                <Scale ScaleX="0.6400" ScaleY="0.6400" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.7074" Y="0.2113" />
                <PreSize X="0.3500" Y="0.3500" />
                <FileData Type="PlistSubImage" Path="power_star.png" Plist="ui/plist/common.plist" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="star2" ActionTag="-1537677049" VisibleForFrame="False" Tag="84" IconVisible="False" LeftMargin="4.3655" RightMargin="60.6345" TopMargin="60.7503" BottomMargin="4.2497" ctype="SpriteObjectData">
                <Size X="35.0000" Y="35.0000" />
                <AnchorPoint ScaleX="0.3000" ScaleY="0.5000" />
                <Position X="14.8655" Y="21.7497" />
                <Scale ScaleX="0.6400" ScaleY="0.6400" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.1487" Y="0.2175" />
                <PreSize X="0.3500" Y="0.3500" />
                <FileData Type="PlistSubImage" Path="power_star.png" Plist="ui/plist/common.plist" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_armynum" ActionTag="-125838138" Tag="157" IconVisible="False" LeftMargin="31.2547" RightMargin="36.7453" TopMargin="59.7762" BottomMargin="15.2238" CharWidth="16" CharHeight="25" LabelText="12" StartChar="0" ctype="TextAtlasObjectData">
                <Size X="32.0000" Y="25.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="47.2547" Y="27.7238" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4725" Y="0.2772" />
                <PreSize X="0.3200" Y="0.2500" />
                <LabelAtlasFileImage_CNB Type="Normal" Path="ui/number_atlas/army_num_out.png" Plist="" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize X="0.1563" Y="0.0880" />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameFile>
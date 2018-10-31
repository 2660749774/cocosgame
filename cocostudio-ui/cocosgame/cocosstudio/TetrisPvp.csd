<GameFile>
  <PropertyGroup Name="TetrisPvp" Type="Scene" ID="41d0e4bd-b29e-4755-b58f-0550a036a535" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene" Tag="24" ctype="GameNodeObjectData">
        <Size X="640.0000" Y="1136.0000" />
        <Children>
          <AbstractNodeData Name="panel" ActionTag="1918327196" Tag="34" IconVisible="False" TopMargin="0.0002" BottomMargin="-0.0002" ClipAble="False" ColorAngle="90.0000" LeftEage="131" RightEage="131" TopEage="288" BottomEage="288" Scale9OriginX="-131" Scale9OriginY="-288" Scale9Width="262" Scale9Height="576" ctype="PanelObjectData">
            <Size X="640.0000" Y="1136.0000" />
            <Children>
              <AbstractNodeData Name="pvp_bg" ActionTag="-355844809" Tag="138" IconVisible="False" LeftMargin="-103.5548" RightMargin="-106.4452" BottomMargin="-0.0001" ctype="SpriteObjectData">
                <Size X="850.0000" Y="1136.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="321.4452" Y="567.9999" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5023" Y="0.5000" />
                <PreSize X="1.3281" Y="1.0000" />
                <FileData Type="Normal" Path="ui/bg/pvp_bg.png" Plist="" />
                <BlendFunc Src="770" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="building_bg" ActionTag="1909827294" Tag="139" IconVisible="False" LeftMargin="110.0000" RightMargin="110.0000" TopMargin="383.0000" BottomMargin="383.0000" ctype="SpriteObjectData">
                <Size X="420.0000" Y="370.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="568.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.5000" />
                <PreSize X="0.6563" Y="0.3257" />
                <FileData Type="Normal" Path="ui/pvp/building_bg.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_pvp" ActionTag="-44138235" Tag="140" IconVisible="False" LeftMargin="174.0000" RightMargin="174.0000" TopMargin="757.0000" BottomMargin="293.0000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="262" Scale9Height="64" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="292.0000" Y="86.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="336.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.2958" />
                <PreSize X="0.4563" Y="0.0757" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="PlistSubImage" Path="btn_pvp.png" Plist="ui/plist/common.plist" />
                <PressedFileData Type="PlistSubImage" Path="btn_pvp.png" Plist="ui/plist/common.plist" />
                <NormalFileData Type="PlistSubImage" Path="btn_pvp.png" Plist="ui/plist/common.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_cancel" ActionTag="54058689" VisibleForFrame="False" Tag="145" IconVisible="False" LeftMargin="174.0000" RightMargin="174.0000" TopMargin="757.0000" BottomMargin="293.0000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="262" Scale9Height="64" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="292.0000" Y="86.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="336.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.2958" />
                <PreSize X="0.4563" Y="0.0757" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="PlistSubImage" Path="btn_cancel.png" Plist="ui/plist/common.plist" />
                <PressedFileData Type="PlistSubImage" Path="btn_cancel.png" Plist="ui/plist/common.plist" />
                <NormalFileData Type="PlistSubImage" Path="btn_cancel.png" Plist="ui/plist/common.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="search_panel" ActionTag="1768075051" VisibleForFrame="False" Tag="144" IconVisible="False" LeftMargin="220.0000" RightMargin="220.0000" TopMargin="221.4702" BottomMargin="814.5298" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="200.0000" Y="100.0000" />
                <Children>
                  <AbstractNodeData Name="btn_matchbg" ActionTag="-418346676" Tag="142" IconVisible="False" LeftMargin="37.5758" RightMargin="-212.5758" TopMargin="87.6412" BottomMargin="-37.6412" ctype="SpriteObjectData">
                    <Size X="375.0000" Y="50.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="225.0758" Y="-12.6412" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="1.1254" Y="-0.1264" />
                    <PreSize X="1.8750" Y="0.5000" />
                    <FileData Type="Normal" Path="ui/pvp/btn_matchbg.png" Plist="" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="btn_search" Visible="False" ActionTag="-1719712251" VisibleForFrame="False" Tag="141" IconVisible="False" LeftMargin="-75.7700" RightMargin="205.7700" TopMargin="61.9300" BottomMargin="-31.9300" ctype="SpriteObjectData">
                    <Size X="70.0000" Y="70.0000" />
                    <AnchorPoint ScaleX="0.3900" ScaleY="0.6500" />
                    <Position X="-48.4700" Y="13.5700" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="-0.2424" Y="0.1357" />
                    <PreSize X="0.3500" Y="0.7000" />
                    <FileData Type="Normal" Path="ui/pvp/btn_search.png" Plist="" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="lb_searchtext" ActionTag="-1430557263" Tag="143" IconVisible="False" LeftMargin="-14.6706" RightMargin="-13.3294" TopMargin="74.9306" BottomMargin="1.0694" FontSize="24" LabelText="正在为您匹配对手..." ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                    <Size X="228.0000" Y="24.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="99.3294" Y="13.0694" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.4966" Y="0.1307" />
                    <PreSize X="1.1400" Y="0.2400" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="26" G="26" B="26" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="864.5298" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.7610" />
                <PreSize X="0.3125" Y="0.0880" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="score_panel" ActionTag="-1435362018" Tag="76" IconVisible="False" LeftMargin="209.0432" RightMargin="230.9568" TopMargin="578.8977" BottomMargin="357.1023" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" ctype="PanelObjectData">
                <Size X="200.0000" Y="200.0000" />
                <Children>
                  <AbstractNodeData Name="score_num" ActionTag="589987707" Tag="75" IconVisible="False" LeftMargin="85.2944" RightMargin="42.7056" TopMargin="129.5903" BottomMargin="36.4097" CharWidth="24" CharHeight="34" LabelText="125" StartChar="0" ctype="TextAtlasObjectData">
                    <Size X="72.0000" Y="34.0000" />
                    <AnchorPoint ScaleY="0.5000" />
                    <Position X="85.2944" Y="53.4097" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.4265" Y="0.2670" />
                    <PreSize X="0.3600" Y="0.1700" />
                    <LabelAtlasFileImage_CNB Type="Normal" Path="ui/number_atlas/number_yellow.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="score_bg" ActionTag="828351778" Tag="74" IconVisible="False" LeftMargin="35.6416" RightMargin="120.3584" TopMargin="126.8641" BottomMargin="37.1359" ctype="SpriteObjectData">
                    <Size X="44.0000" Y="36.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="57.6416" Y="55.1359" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.2882" Y="0.2757" />
                    <PreSize X="0.2200" Y="0.1800" />
                    <FileData Type="PlistSubImage" Path="score_bg.png" Plist="ui/plist/common.plist" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="309.0432" Y="457.1023" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4829" Y="0.4024" />
                <PreSize X="0.3125" Y="0.1761" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
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
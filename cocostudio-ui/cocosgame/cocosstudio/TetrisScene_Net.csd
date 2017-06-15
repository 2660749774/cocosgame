<GameFile>
  <PropertyGroup Name="TetrisScene_Net" Type="Scene" ID="795413a3-2586-4371-9d94-61efcce58dd4" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene" Tag="24" ctype="GameNodeObjectData">
        <Size X="640.0000" Y="1136.0000" />
        <Children>
          <AbstractNodeData Name="panel" ActionTag="1918327196" Tag="34" IconVisible="False" TouchEnable="True" ClipAble="False" ColorAngle="90.0000" LeftEage="131" RightEage="131" TopEage="288" BottomEage="288" Scale9OriginX="-131" Scale9OriginY="-288" Scale9Width="262" Scale9Height="576" ctype="PanelObjectData">
            <Size X="640.0000" Y="1136.0000" />
            <Children>
              <AbstractNodeData Name="scene_bg" ActionTag="-389944647" Tag="64" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="-106.8960" RightMargin="-105.1040" TopMargin="-0.9088" BottomMargin="0.9088" LeftEage="281" RightEage="281" TopEage="374" BottomEage="374" Scale9OriginX="281" Scale9OriginY="374" Scale9Width="290" Scale9Height="388" ctype="ImageViewObjectData">
                <Size X="852.0000" Y="1136.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="319.1040" Y="568.9088" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4986" Y="0.5008" />
                <PreSize X="1.3312" Y="1.0000" />
                <FileData Type="Normal" Path="ui/bg/multimatch_bg.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="net_title_bg" ActionTag="-1568870208" Tag="57" IconVisible="False" LeftMargin="-107.6230" RightMargin="-104.3770" BottomMargin="1021.0000" ctype="SpriteObjectData">
                <Size X="852.0000" Y="115.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="318.3770" Y="1078.5000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4975" Y="0.9494" />
                <PreSize X="1.3312" Y="0.1012" />
                <FileData Type="Normal" Path="ui/pvp/net_title_bg.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="tetris_bg" ActionTag="1184616726" Tag="56" IconVisible="False" ctype="SpriteObjectData">
                <Size X="640.0000" Y="1136.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="568.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.5000" />
                <PreSize X="1.0000" Y="1.0000" />
                <FileData Type="Normal" Path="ui/bg/net_bg.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="tetris_panel_self" ActionTag="1060537929" Tag="32" IconVisible="False" LeftMargin="12.5400" RightMargin="354.4600" TopMargin="268.0797" BottomMargin="324.9203" TouchEnable="True" ClipAble="True" BackColorAlpha="76" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="273.0000" Y="543.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="149.0400" Y="596.4203" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.2329" Y="0.5250" />
                <PreSize X="0.4266" Y="0.4780" />
                <SingleColor A="255" R="0" G="0" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="tetris_panel_target" ActionTag="1651447180" Tag="40" IconVisible="False" LeftMargin="354.7408" RightMargin="12.2592" TopMargin="266.2200" BottomMargin="326.7800" TouchEnable="True" ClipAble="True" BackColorAlpha="76" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="273.0000" Y="543.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="491.2408" Y="598.2800" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.7676" Y="0.5267" />
                <PreSize X="0.4266" Y="0.4780" />
                <SingleColor A="255" R="255" G="0" B="0" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_down_low" ActionTag="618124103" Tag="15" IconVisible="False" LeftMargin="125.3403" RightMargin="418.6597" TopMargin="1019.4208" BottomMargin="20.5792" TouchEnable="True" FontSize="28" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="66" Scale9Height="74" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="96.0000" Y="96.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="173.3403" Y="68.5792" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.2708" Y="0.0604" />
                <PreSize X="0.1500" Y="0.0845" />
                <TextColor A="255" R="255" G="255" B="255" />
                <DisabledFileData Type="PlistSubImage" Path="down.png" Plist="ui/plist/common.plist" />
                <PressedFileData Type="PlistSubImage" Path="down.png" Plist="ui/plist/common.plist" />
                <NormalFileData Type="PlistSubImage" Path="down.png" Plist="ui/plist/common.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_down" ActionTag="1650258263" Tag="42" IconVisible="False" LeftMargin="125.6924" RightMargin="418.3076" TopMargin="873.9659" BottomMargin="166.0341" TouchEnable="True" FontSize="28" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="66" Scale9Height="74" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="96.0000" Y="96.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="173.6924" Y="214.0341" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.2714" Y="0.1884" />
                <PreSize X="0.1500" Y="0.0845" />
                <TextColor A="255" R="255" G="255" B="255" />
                <DisabledFileData Type="PlistSubImage" Path="down_fast.png" Plist="ui/plist/common.plist" />
                <PressedFileData Type="PlistSubImage" Path="down_fast.png" Plist="ui/plist/common.plist" />
                <NormalFileData Type="PlistSubImage" Path="down_fast.png" Plist="ui/plist/common.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="info_panel_self" ActionTag="-2035783800" Tag="61" IconVisible="False" LeftMargin="9.3325" RightMargin="465.6675" TopMargin="150.2656" BottomMargin="870.7344" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="165.0000" Y="115.0000" />
                <Children>
                  <AbstractNodeData Name="lb_score_title" ActionTag="694093863" Tag="62" IconVisible="False" LeftMargin="6.7196" RightMargin="102.2804" TopMargin="9.5841" BottomMargin="77.4159" FontSize="28" LabelText="分数" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                    <Size X="56.0000" Y="28.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="34.7196" Y="91.4159" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.2104" Y="0.7949" />
                    <PreSize X="0.3394" Y="0.2435" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="0" G="0" B="0" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="lb_score_self" ActionTag="365132359" Tag="63" IconVisible="False" LeftMargin="28.6891" RightMargin="16.3109" TopMargin="45.2919" BottomMargin="19.7081" CharWidth="30" CharHeight="50" LabelText="5211" StartChar="0" ctype="TextAtlasObjectData">
                    <Size X="120.0000" Y="50.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="88.6891" Y="44.7081" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5375" Y="0.3888" />
                    <PreSize X="0.7273" Y="0.4348" />
                    <LabelAtlasFileImage_CNB Type="Normal" Path="ui/number_atlas/number.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="next_bg_self" ActionTag="1186324978" Tag="64" IconVisible="False" LeftMargin="175.9854" RightMargin="-100.9854" TopMargin="12.0222" BottomMargin="12.9778" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                    <Size X="90.0000" Y="90.0000" />
                    <AnchorPoint />
                    <Position X="175.9854" Y="12.9778" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="1.0666" Y="0.1129" />
                    <PreSize X="0.5455" Y="0.7826" />
                    <SingleColor A="255" R="150" G="200" B="255" />
                    <FirstColor A="255" R="150" G="200" B="255" />
                    <EndColor A="255" R="255" G="255" B="255" />
                    <ColorVector ScaleY="1.0000" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="9.3325" Y="870.7344" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.0146" Y="0.7665" />
                <PreSize X="0.2578" Y="0.1012" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="info_panel_target" ActionTag="68531187" Tag="60" IconVisible="False" LeftMargin="465.2993" RightMargin="9.7007" TopMargin="148.3854" BottomMargin="872.6146" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="165.0000" Y="115.0000" />
                <Children>
                  <AbstractNodeData Name="lb_score_title" ActionTag="201596579" Tag="59" IconVisible="False" LeftMargin="95.6396" RightMargin="13.3604" TopMargin="12.4551" BottomMargin="74.5449" FontSize="28" LabelText="分数" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                    <Size X="56.0000" Y="28.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="123.6396" Y="88.5449" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.7493" Y="0.7700" />
                    <PreSize X="0.3394" Y="0.2435" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="0" G="0" B="0" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="lb_score_target" ActionTag="-1933401380" Tag="65" IconVisible="False" LeftMargin="25.6887" RightMargin="19.3113" TopMargin="46.2920" BottomMargin="18.7080" CharWidth="30" CharHeight="50" LabelText="5211" StartChar="0" ctype="TextAtlasObjectData">
                    <Size X="120.0000" Y="50.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="85.6887" Y="43.7080" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5193" Y="0.3801" />
                    <PreSize X="0.7273" Y="0.4348" />
                    <LabelAtlasFileImage_CNB Type="Normal" Path="ui/number_atlas/number.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="next_bg_target" ActionTag="-1369861544" Tag="71" IconVisible="False" LeftMargin="-100.0371" RightMargin="175.0371" TopMargin="13.0110" BottomMargin="11.9890" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                    <Size X="90.0000" Y="90.0000" />
                    <AnchorPoint />
                    <Position X="-100.0371" Y="11.9890" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="-0.6063" Y="0.1043" />
                    <PreSize X="0.5455" Y="0.7826" />
                    <SingleColor A="255" R="150" G="200" B="255" />
                    <FirstColor A="255" R="150" G="200" B="255" />
                    <EndColor A="255" R="255" G="255" B="255" />
                    <ColorVector ScaleY="1.0000" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint />
                <Position X="465.2993" Y="872.6146" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.7270" Y="0.7681" />
                <PreSize X="0.2578" Y="0.1012" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_play" ActionTag="608945743" Tag="41" IconVisible="False" LeftMargin="202.6038" RightMargin="197.3962" TopMargin="399.6525" BottomMargin="616.3475" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="210" Scale9Height="98" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="240.0000" Y="120.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="322.6038" Y="676.3475" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5041" Y="0.5954" />
                <PreSize X="0.3750" Y="0.1056" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="PlistSubImage" Path="PlayButton.png" Plist="res/pack.plist" />
                <PressedFileData Type="PlistSubImage" Path="PlayButton.png" Plist="res/pack.plist" />
                <NormalFileData Type="PlistSubImage" Path="PlayButton.png" Plist="res/pack.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_shift" ActionTag="-1740025647" Tag="27" IconVisible="False" LeftMargin="450.7410" RightMargin="36.2590" TopMargin="943.0548" BottomMargin="39.9452" TouchEnable="True" FontSize="28" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="123" Scale9Height="131" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="153.0000" Y="153.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="527.2410" Y="116.4452" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.8238" Y="0.1025" />
                <PreSize X="0.2391" Y="0.1347" />
                <TextColor A="255" R="255" G="255" B="255" />
                <DisabledFileData Type="PlistSubImage" Path="shift.png" Plist="ui/plist/common.plist" />
                <PressedFileData Type="PlistSubImage" Path="shift.png" Plist="ui/plist/common.plist" />
                <NormalFileData Type="PlistSubImage" Path="shift.png" Plist="ui/plist/common.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_right" ActionTag="-1978374155" Tag="26" IconVisible="False" LeftMargin="222.1837" RightMargin="321.8163" TopMargin="944.4210" BottomMargin="95.5790" TouchEnable="True" FontSize="28" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="66" Scale9Height="74" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="96.0000" Y="96.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="270.1837" Y="143.5790" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4222" Y="0.1264" />
                <PreSize X="0.1500" Y="0.0845" />
                <TextColor A="255" R="255" G="255" B="255" />
                <DisabledFileData Type="PlistSubImage" Path="right.png" Plist="ui/plist/common.plist" />
                <PressedFileData Type="PlistSubImage" Path="right.png" Plist="ui/plist/common.plist" />
                <NormalFileData Type="PlistSubImage" Path="right.png" Plist="ui/plist/common.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_left" ActionTag="-780245045" Tag="25" IconVisible="False" LeftMargin="31.0177" RightMargin="512.9823" TopMargin="944.4210" BottomMargin="95.5790" TouchEnable="True" FontSize="28" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="66" Scale9Height="74" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="96.0000" Y="96.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="79.0177" Y="143.5790" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.1235" Y="0.1264" />
                <PreSize X="0.1500" Y="0.0845" />
                <TextColor A="255" R="255" G="255" B="255" />
                <DisabledFileData Type="PlistSubImage" Path="left.png" Plist="ui/plist/common.plist" />
                <PressedFileData Type="PlistSubImage" Path="left.png" Plist="ui/plist/common.plist" />
                <NormalFileData Type="PlistSubImage" Path="left.png" Plist="ui/plist/common.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_ping" ActionTag="230511841" Tag="67" IconVisible="False" LeftMargin="452.7345" RightMargin="79.2655" TopMargin="869.7484" BottomMargin="242.2516" FontSize="24" LabelText="ping: 100" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="108.0000" Y="24.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="506.7345" Y="254.2516" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.7918" Y="0.2238" />
                <PreSize X="0.1688" Y="0.0211" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
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
          <AbstractNodeData Name="player_panel_self" ActionTag="-151004393" Tag="69" IconVisible="False" LeftMargin="-0.6215" RightMargin="370.6215" TopMargin="1.1417" BottomMargin="1024.8583" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
            <Size X="270.0000" Y="110.0000" />
            <Children>
              <AbstractNodeData Name="lb_player_name_self" ActionTag="1941520178" Tag="70" IconVisible="False" LeftMargin="111.7779" RightMargin="2.2221" TopMargin="10.4099" BottomMargin="75.5901" FontSize="24" LabelText="玩家名字7个字" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                <Size X="156.0000" Y="24.0000" />
                <AnchorPoint />
                <Position X="111.7779" Y="75.5901" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4140" Y="0.6872" />
                <PreSize X="0.5778" Y="0.2182" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_player_score_self" ActionTag="-928415396" Tag="71" IconVisible="False" LeftMargin="111.7779" RightMargin="26.2221" TopMargin="37.7818" BottomMargin="48.2182" FontSize="24" LabelText="积分1234444" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                <Size X="132.0000" Y="24.0000" />
                <AnchorPoint />
                <Position X="111.7779" Y="48.2182" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4140" Y="0.4383" />
                <PreSize X="0.4889" Y="0.2182" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="pic_blue_bg_self" ActionTag="-875723715" Tag="72" IconVisible="False" LeftMargin="1.0723" RightMargin="158.9277" TopMargin="-0.4307" BottomMargin="0.4307" ctype="SpriteObjectData">
                <Size X="110.0000" Y="110.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="56.0723" Y="55.4307" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.2077" Y="0.5039" />
                <PreSize X="0.4074" Y="1.0000" />
                <FileData Type="Normal" Path="ui/pvp/pic_blue_bg.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="134.3785" Y="1079.8583" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.2100" Y="0.9506" />
            <PreSize X="0.4219" Y="0.0968" />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="player_panel_target" ActionTag="-2025356879" Tag="66" IconVisible="False" LeftMargin="371.5408" RightMargin="-1.5408" TopMargin="1.1421" BottomMargin="1024.8579" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
            <Size X="270.0000" Y="110.0000" />
            <Children>
              <AbstractNodeData Name="lb_player_name_target" ActionTag="-1846631315" Tag="67" IconVisible="False" LeftMargin="-0.1769" RightMargin="114.1769" TopMargin="76.6841" BottomMargin="9.3159" FontSize="24" LabelText="玩家名字7个字" HorizontalAlignmentType="HT_Right" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                <Size X="156.0000" Y="24.0000" />
                <AnchorPoint ScaleX="1.0000" />
                <Position X="155.8231" Y="9.3159" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5771" Y="0.0847" />
                <PreSize X="0.5778" Y="0.2182" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_player_score_target" ActionTag="-1797019571" Tag="68" IconVisible="False" LeftMargin="23.8229" RightMargin="114.1771" TopMargin="50.7229" BottomMargin="35.2771" FontSize="24" LabelText="积分1234444" HorizontalAlignmentType="HT_Right" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                <Size X="132.0000" Y="24.0000" />
                <AnchorPoint ScaleX="1.0000" />
                <Position X="155.8229" Y="35.2771" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5771" Y="0.3207" />
                <PreSize X="0.4889" Y="0.2182" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="pic_red_bg_target" ActionTag="1515233320" Tag="65" IconVisible="False" LeftMargin="156.2098" RightMargin="3.7902" TopMargin="-0.4305" BottomMargin="0.4305" ctype="SpriteObjectData">
                <Size X="110.0000" Y="110.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="211.2098" Y="55.4305" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.7823" Y="0.5039" />
                <PreSize X="0.4074" Y="1.0000" />
                <FileData Type="Normal" Path="ui/pvp/pic_red_bg.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="506.5408" Y="1079.8579" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.7915" Y="0.9506" />
            <PreSize X="0.4219" Y="0.0968" />
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
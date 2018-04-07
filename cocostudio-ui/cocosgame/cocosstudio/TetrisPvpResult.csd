<GameFile>
  <PropertyGroup Name="TetrisPvpResult" Type="Scene" ID="83fc333d-2054-4f24-8da0-62d90b22a6fb" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="0.1667" />
      <ObjectData Name="Scene" Tag="80" ctype="GameNodeObjectData">
        <Size X="640.0000" Y="1136.0000" />
        <Children>
          <AbstractNodeData Name="panel" ActionTag="-1158975453" Tag="85" IconVisible="False" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
            <Size X="640.0000" Y="1136.0000" />
            <Children>
              <AbstractNodeData Name="bg" ActionTag="-1117574905" Tag="170" IconVisible="False" LeftMargin="-106.0000" RightMargin="-106.0000" ctype="SpriteObjectData">
                <Size X="852.0000" Y="1136.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="568.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.5000" />
                <PreSize X="1.3312" Y="1.0000" />
                <FileData Type="Normal" Path="ui/pvp/red_win_bg.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="Sprite_2" ActionTag="-809903815" Tag="54" IconVisible="False" LeftMargin="14.9997" RightMargin="355.0003" TopMargin="445.0023" BottomMargin="540.9977" ctype="SpriteObjectData">
                <Size X="270.0000" Y="150.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="149.9997" Y="615.9977" />
                <Scale ScaleX="-1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.2344" Y="0.5423" />
                <PreSize X="0.4219" Y="0.1320" />
                <FileData Type="Normal" Path="ui/pvp/pvp_result.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="Sprite_2_0" ActionTag="1901063612" Tag="55" IconVisible="False" LeftMargin="352.4604" RightMargin="17.5396" TopMargin="445.0000" BottomMargin="541.0000" ctype="SpriteObjectData">
                <Size X="270.0000" Y="150.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="487.4604" Y="616.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.7617" Y="0.5423" />
                <PreSize X="0.4219" Y="0.1320" />
                <FileData Type="Normal" Path="ui/pvp/pvp_result.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="end_bg" ActionTag="-939300292" Tag="53" IconVisible="False" LeftMargin="30.0000" RightMargin="30.0000" TopMargin="287.4975" BottomMargin="628.5025" ctype="SpriteObjectData">
                <Size X="580.0000" Y="220.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="738.5025" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.6501" />
                <PreSize X="0.9063" Y="0.1937" />
                <FileData Type="Normal" Path="ui/pvp/pvp_end_bg.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_ok" ActionTag="1401867083" Tag="56" IconVisible="False" LeftMargin="173.9998" RightMargin="174.0002" TopMargin="867.0042" BottomMargin="182.9958" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="262" Scale9Height="64" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="292.0000" Y="86.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="319.9998" Y="225.9958" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.1989" />
                <PreSize X="0.4563" Y="0.0757" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="PlistSubImage" Path="btn_ok.png" Plist="ui/plist/common.plist" />
                <PressedFileData Type="PlistSubImage" Path="btn_ok.png" Plist="ui/plist/common.plist" />
                <NormalFileData Type="PlistSubImage" Path="btn_ok.png" Plist="ui/plist/common.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="self_panel" ActionTag="765316254" Tag="59" IconVisible="False" LeftMargin="42.0000" RightMargin="398.0000" TopMargin="564.9639" BottomMargin="471.0361" TouchEnable="True" ClipAble="False" BackColorAlpha="0" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="200.0000" Y="100.0000" />
                <Children>
                  <AbstractNodeData Name="score_panel_self" ActionTag="452516772" Tag="27" IconVisible="False" LeftMargin="51.2287" RightMargin="38.7713" TopMargin="31.8663" BottomMargin="28.1337" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                    <Size X="110.0000" Y="40.0000" />
                    <Children>
                      <AbstractNodeData Name="Sprite_4" ActionTag="1782042028" Tag="57" IconVisible="False" LeftMargin="-0.0001" RightMargin="0.0001" TopMargin="0.2599" BottomMargin="-0.2599" ctype="SpriteObjectData">
                        <Size X="110.0000" Y="40.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="54.9999" Y="19.7401" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.4935" />
                        <PreSize X="1.0000" Y="1.0000" />
                        <FileData Type="Normal" Path="ui/pvp/pvp_score_bg.png" Plist="" />
                        <BlendFunc Src="1" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Sprite_5" ActionTag="76693203" Tag="58" IconVisible="False" LeftMargin="-15.7094" RightMargin="81.7094" TopMargin="2.0000" BottomMargin="2.0000" ctype="SpriteObjectData">
                        <Size X="44.0000" Y="36.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="6.2906" Y="20.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.0572" Y="0.5000" />
                        <PreSize X="0.4000" Y="0.9000" />
                        <FileData Type="PlistSubImage" Path="score_bg.png" Plist="ui/plist/common.plist" />
                        <BlendFunc Src="1" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="lb_score_self" ActionTag="-34916678" Tag="60" IconVisible="False" LeftMargin="39.5174" RightMargin="34.4826" TopMargin="8.0000" BottomMargin="8.0000" FontSize="24" LabelText="+23" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                        <Size X="36.0000" Y="24.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="57.5174" Y="20.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5229" Y="0.5000" />
                        <PreSize X="0.3273" Y="0.6000" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="0" G="0" B="0" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="106.2287" Y="48.1337" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5311" Y="0.4813" />
                    <PreSize X="0.5500" Y="0.4000" />
                    <SingleColor A="255" R="150" G="200" B="255" />
                    <FirstColor A="255" R="150" G="200" B="255" />
                    <EndColor A="255" R="255" G="255" B="255" />
                    <ColorVector ScaleY="1.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="lb_num_self" ActionTag="1234436759" Tag="70" IconVisible="False" LeftMargin="52.5723" RightMargin="51.4277" TopMargin="-18.8784" BottomMargin="84.8784" CharWidth="24" CharHeight="34" LabelText="1200" StartChar="0" ctype="TextAtlasObjectData">
                    <Size X="96.0000" Y="34.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="100.5723" Y="101.8784" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5029" Y="1.0188" />
                    <PreSize X="0.4800" Y="0.3400" />
                    <LabelAtlasFileImage_CNB Type="Normal" Path="ui/number_atlas/number_yellow.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="lb_name_self" ActionTag="184388121" Tag="67" IconVisible="False" LeftMargin="42.0253" RightMargin="5.9747" TopMargin="-235.7489" BottomMargin="297.7489" FontSize="38" LabelText="收集星星" ShadowOffsetX="2.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                    <Size X="152.0000" Y="38.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="118.0253" Y="316.7489" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="104" G="178" B="246" />
                    <PrePosition X="0.5901" Y="3.1675" />
                    <PreSize X="0.7600" Y="0.3800" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="0" G="0" B="0" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="win_self" ActionTag="-1444034693" Tag="68" IconVisible="False" LeftMargin="36.2883" RightMargin="-6.2883" TopMargin="-172.5608" BottomMargin="212.5608" ctype="SpriteObjectData">
                    <Size X="170.0000" Y="60.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="121.2883" Y="242.5608" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.6064" Y="2.4256" />
                    <PreSize X="0.8500" Y="0.6000" />
                    <FileData Type="PlistSubImage" Path="winner.png" Plist="ui/plist/common.plist" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="142.0000" Y="521.0361" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.2219" Y="0.4587" />
                <PreSize X="0.3125" Y="0.0880" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="target_Panel" ActionTag="442924721" Tag="61" IconVisible="False" LeftMargin="391.8362" RightMargin="48.1638" TopMargin="564.9639" BottomMargin="471.0361" TouchEnable="True" ClipAble="False" BackColorAlpha="0" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="200.0000" Y="100.0000" />
                <Children>
                  <AbstractNodeData Name="score_panel_target" ActionTag="-89716859" Tag="28" IconVisible="False" LeftMargin="48.7094" RightMargin="41.2906" TopMargin="31.8663" BottomMargin="28.1337" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                    <Size X="110.0000" Y="40.0000" />
                    <Children>
                      <AbstractNodeData Name="Sprite_4" ActionTag="-1684429648" Tag="62" IconVisible="False" LeftMargin="-0.0001" RightMargin="0.0001" TopMargin="-2.2599" BottomMargin="2.2599" ctype="SpriteObjectData">
                        <Size X="110.0000" Y="40.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="54.9999" Y="22.2599" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5000" Y="0.5565" />
                        <PreSize X="1.0000" Y="1.0000" />
                        <FileData Type="Normal" Path="ui/pvp/pvp_score_bg.png" Plist="" />
                        <BlendFunc Src="1" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="Sprite_5" ActionTag="2117383680" Tag="63" IconVisible="False" LeftMargin="-15.7100" RightMargin="81.7100" TopMargin="2.0000" BottomMargin="2.0000" ctype="SpriteObjectData">
                        <Size X="44.0000" Y="36.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="6.2900" Y="20.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.0572" Y="0.5000" />
                        <PreSize X="0.4000" Y="0.9000" />
                        <FileData Type="PlistSubImage" Path="score_bg.png" Plist="ui/plist/common.plist" />
                        <BlendFunc Src="1" Dst="771" />
                      </AbstractNodeData>
                      <AbstractNodeData Name="lb_score_target" ActionTag="905156974" Tag="64" IconVisible="False" LeftMargin="39.5200" RightMargin="34.4800" TopMargin="8.0000" BottomMargin="8.0000" FontSize="24" LabelText="+23" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                        <Size X="36.0000" Y="24.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="57.5200" Y="20.0000" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="255" G="255" B="255" />
                        <PrePosition X="0.5229" Y="0.5000" />
                        <PreSize X="0.3273" Y="0.6000" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="0" G="0" B="0" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="103.7094" Y="48.1337" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5185" Y="0.4813" />
                    <PreSize X="0.5500" Y="0.4000" />
                    <SingleColor A="255" R="150" G="200" B="255" />
                    <FirstColor A="255" R="150" G="200" B="255" />
                    <EndColor A="255" R="255" G="255" B="255" />
                    <ColorVector ScaleY="1.0000" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="lb_num_target" ActionTag="857705663" Tag="71" IconVisible="False" LeftMargin="49.5726" RightMargin="54.4274" TopMargin="-18.8782" BottomMargin="84.8782" CharWidth="24" CharHeight="34" LabelText="1200" StartChar="0" ctype="TextAtlasObjectData">
                    <Size X="96.0000" Y="34.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="97.5726" Y="101.8782" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.4879" Y="1.0188" />
                    <PreSize X="0.4800" Y="0.3400" />
                    <LabelAtlasFileImage_CNB Type="Normal" Path="ui/number_atlas/number_yellow.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="lb_name_target" ActionTag="831547471" Tag="66" IconVisible="False" LeftMargin="23.5108" RightMargin="24.4892" TopMargin="-235.7489" BottomMargin="297.7489" FontSize="38" LabelText="收集星星" ShadowOffsetX="2.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                    <Size X="152.0000" Y="38.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="99.5108" Y="316.7489" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="242" G="102" B="139" />
                    <PrePosition X="0.4976" Y="3.1675" />
                    <PreSize X="0.7600" Y="0.3800" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="11" G="29" B="26" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="win_target" ActionTag="-820574566" Tag="69" IconVisible="False" LeftMargin="19.0204" RightMargin="10.9796" TopMargin="-172.5608" BottomMargin="212.5608" ctype="SpriteObjectData">
                    <Size X="170.0000" Y="60.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="104.0204" Y="242.5608" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5201" Y="2.4256" />
                    <PreSize X="0.8500" Y="0.6000" />
                    <FileData Type="PlistSubImage" Path="winner.png" Plist="ui/plist/common.plist" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="491.8362" Y="521.0361" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.7685" Y="0.4587" />
                <PreSize X="0.3125" Y="0.0880" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="task_info" ActionTag="-1853190896" VisibleForFrame="False" Tag="58" IconVisible="False" LeftMargin="56.2470" RightMargin="383.7530" TopMargin="663.2866" BottomMargin="272.7134" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" ctype="PanelObjectData">
                <Size X="200.0000" Y="200.0000" />
                <Children>
                  <AbstractNodeData Name="task_icon" ActionTag="-185815042" Tag="54" IconVisible="False" LeftMargin="-206.7085" RightMargin="-105.2915" TopMargin="-172.0919" BottomMargin="-139.9081" ctype="SpriteObjectData">
                    <Size X="512.0000" Y="512.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="49.2915" Y="116.0919" />
                    <Scale ScaleX="0.1858" ScaleY="0.1858" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.2465" Y="0.5805" />
                    <PreSize X="2.5600" Y="2.5600" />
                    <FileData Type="Normal" Path="ui/common/task.png" Plist="" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="task_name" ActionTag="1370498962" Tag="55" IconVisible="False" LeftMargin="101.9087" RightMargin="-31.9087" TopMargin="45.9422" BottomMargin="128.0578" FontSize="26" LabelText="参与1场PVP" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                    <Size X="130.0000" Y="26.0000" />
                    <AnchorPoint ScaleY="0.5000" />
                    <Position X="101.9087" Y="141.0578" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5095" Y="0.7053" />
                    <PreSize X="0.6500" Y="0.1300" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="0" G="0" B="0" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="reward_icon" ActionTag="-1315601374" Tag="56" IconVisible="False" LeftMargin="98.6710" RightMargin="57.3290" TopMargin="82.4738" BottomMargin="73.5262" LeftEage="14" RightEage="14" TopEage="14" BottomEage="14" Scale9OriginX="14" Scale9OriginY="14" Scale9Width="16" Scale9Height="16" ctype="ImageViewObjectData">
                    <Size X="44.0000" Y="44.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="120.6710" Y="95.5262" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.6034" Y="0.4776" />
                    <PreSize X="0.2200" Y="0.2200" />
                    <FileData Type="Normal" Path="icon/gem_bg.png" Plist="" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="reward_num" ActionTag="1341612246" Tag="57" IconVisible="False" LeftMargin="146.3266" RightMargin="5.6734" TopMargin="91.4756" BottomMargin="84.5244" FontSize="24" LabelText="×10" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                    <Size X="48.0000" Y="24.0000" />
                    <AnchorPoint ScaleY="0.5000" />
                    <Position X="146.3266" Y="96.5244" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.7316" Y="0.4826" />
                    <PreSize X="0.2400" Y="0.1200" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="0" G="0" B="0" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="task_done_icon" ActionTag="-1068811296" VisibleForFrame="False" Tag="59" IconVisible="False" LeftMargin="202.8907" RightMargin="-130.8907" TopMargin="19.5415" BottomMargin="50.4585" ctype="SpriteObjectData">
                    <Size X="128.0000" Y="130.0000" />
                    <Children>
                      <AbstractNodeData Name="task_done_txt" ActionTag="-263166577" Tag="60" RotationSkewX="-51.1990" RotationSkewY="-51.1990" IconVisible="False" LeftMargin="36.0313" RightMargin="35.9687" TopMargin="50.8275" BottomMargin="51.1725" FontSize="28" LabelText="完成" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                        <Size X="56.0000" Y="28.0000" />
                        <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                        <Position X="64.0313" Y="65.1725" />
                        <Scale ScaleX="1.0000" ScaleY="1.0000" />
                        <CColor A="255" R="0" G="181" B="105" />
                        <PrePosition X="0.5002" Y="0.5013" />
                        <PreSize X="0.4375" Y="0.2154" />
                        <OutlineColor A="255" R="255" G="0" B="0" />
                        <ShadowColor A="255" R="159" G="1" B="0" />
                      </AbstractNodeData>
                    </Children>
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="266.8907" Y="115.4585" />
                    <Scale ScaleX="0.7300" ScaleY="0.7300" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="1.3345" Y="0.5773" />
                    <PreSize X="0.6400" Y="0.6500" />
                    <FileData Type="Normal" Path="ui/common/timg.png" Plist="" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="156.2470" Y="372.7134" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.2441" Y="0.3281" />
                <PreSize X="0.3125" Y="0.1761" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="320.0000" Y="568.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize X="1.0000" Y="1.0000" />
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
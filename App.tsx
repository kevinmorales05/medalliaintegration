/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React from 'react';
import type {PropsWithChildren} from 'react';
import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  useColorScheme,
  View,
  Button,
  Platform
} from 'react-native';
import { MedalliaDigital } from './sdk/medallia-digital-rn';


import {
  Colors,
  DebugInstructions,
  Header,
  LearnMoreLinks,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';
const androidToken = "eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhcGlUb2tlblYyIiwiYXV0aFVybCI6Imh0dHBzOi8vc2V2ZW5lbGV2ZW5tZXgubWQtYXBpcy5tZWRhbGxpYS5jb20vbW9iaWxlU0RLL3YxL2FjY2Vzc1Rva2VuIiwiZW52aXJvbm1lbnQiOiJkaWdpdGFsLWNsb3VkLXdlc3QiLCJjcmVhdGVUaW1lIjoxNjQyMDk4NzQ5OTg1LCJkb21haW4iOiJodHRwczovL3NldmVuZWxldmVubWV4Lm1kLWFwaXMubWVkYWxsaWEuY29tLyIsImFwaVRva2VuVjJWZXJzaW9uIjoyLCJwcm9wZXJ0eUlkIjoxNzg5MTF9.i3Zda3R4YBofFLS9i_RJxrERuZr-s-T6l0sg6gt6p973zAV-BUvc6Ii1ofkLyZahltQvl8CxefhBtmadAFHmKNUJl0h9jHeOm-d9KdJEA5rJi73HpVWf2VMcpYJ0QKnpKm24lan37hivIaiCemxgCEu-Ju3vyf5ZNGgekX2VsPUVrZtmBo9mJzyWBRyQi6n6C_6xjIMoZD_rhU7cEIDuDZJM_mlmGBKvYcmRO8h5DjX6cQvL0c8Poow1DJKxCvQZ9p575m4vlB7-m4QO3xlXCO48Li93McpuViJpdAehy6D3xMvsLYByM7ynlffJUtfwoXpuJ_xcR_bwQqaC82Rlpw";
const iosToken = "eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhcGlUb2tlblYyIiwiYXV0aFVybCI6Imh0dHBzOi8vc2V2ZW5lbGV2ZW5tZXgubWQtYXBpcy5tZWRhbGxpYS5jb20vbW9iaWxlU0RLL3YxL2FjY2Vzc1Rva2VuIiwiZW52aXJvbm1lbnQiOiJkaWdpdGFsLWNsb3VkLXdlc3QiLCJjcmVhdGVUaW1lIjoxNjQyMDk4NzQ3NzI4LCJkb21haW4iOiJodHRwczovL3NldmVuZWxldmVubWV4Lm1kLWFwaXMubWVkYWxsaWEuY29tLyIsImFwaVRva2VuVjJWZXJzaW9uIjoyLCJwcm9wZXJ0eUlkIjoxNzg5MDB9.CgyTKSlE0yke6W0n58DWNd-DhHCSwhpzCMiHpcQjz2OIDU42pchIa4qgaPACMNKhVRQgba3FRX6Gsez7kY45ONuQv5bXI9wmjJO1Rav5NyRE9qNu7pl24Uo4QeqHFRJhZB8J4eIyEMyPCCVRTg4EflAhQvDJBrDkPJKP89CYWSfyYwtA-JpLgYMx125aq-q71bv_6wrgIi3HAIXLLhTzVJwVVQsKtxMLp6QVVVr2qriyPAA2ngbdWQflucwr7WZ9dH95ZbQj1OUcyY4IuPGp3kwG4APErE4TT4UCvdx9wkUh0lvQQCmtsb55JpkvvPEUulb5NCrPjexoEFqm_JkGMQ";


type SectionProps = PropsWithChildren<{
  title: string;
}>;

function Section({children, title}: SectionProps): JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';
  
  return (
    <View style={styles.sectionContainer}>
      <Text
        style={[
          styles.sectionTitle,
          {
            color: isDarkMode ? Colors.white : Colors.black,
          },
        ]}>
        {title}
      </Text>
      <Text
        style={[
          styles.sectionDescription,
          {
            color: isDarkMode ? Colors.light : Colors.dark,
          },
        ]}>
        {children}
      </Text>
    </View>
  );
}

function App(): JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  return (
    <SafeAreaView style={backgroundStyle}>
      <StatusBar
        barStyle={isDarkMode ? 'light-content' : 'dark-content'}
        backgroundColor={backgroundStyle.backgroundColor}
      />
      <ScrollView
        contentInsetAdjustmentBehavior="automatic"
        style={backgroundStyle}>
        <Header />
        <View
          style={{
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
          }}>
          <Section title="Step One">
            Edit <Text style={styles.highlight}>App.tsx</Text> to change this
            screen and then come back to see your edits.
          </Section>
          <Section title="See Your Changes">
            <ReloadInstructions />
          </Section>
          <Section title="Debug">
            <DebugInstructions />
          </Section>
          <Section title="Learn More">
            Read the docs to discover what to do next:
          </Section>
          <LearnMoreLinks />

          <Button
  onPress={()=> {
    console.log("button");
    MedalliaDigital.showForm('8385');
    


}}
  title="Learn More"
  color="#841584"
  accessibilityLabel="Learn more about this purple button"
/>
          
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
  },
  highlight: {
    fontWeight: '700',
  },
});

export default App;

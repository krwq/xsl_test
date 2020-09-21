<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" version="1.0" encoding="utf-8" />
	<xsl:template match="/">
		<SmsFileInfo xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">

			<xsl:variable name="event">
				<xsl:value-of select="Shipment//Event/StatusText"/>
			</xsl:variable>

			<xsl:variable name="installationId">
				<xsl:value-of select="normalize-space(Shipment/InstallationId)"/>
			</xsl:variable>

			<xsl:variable name="actorId">
				<xsl:value-of select="Shipment/ActorCsid"/>
			</xsl:variable>

			<xsl:variable name="actorName">
				<xsl:value-of select="Shipment/ActorName"/>
			</xsl:variable>

			<xsl:variable name="locationID">
				<xsl:value-of select="Shipment/LocationId"/>
			</xsl:variable>

			<xsl:variable name="locationName">
				<xsl:value-of select="Shipment/LocationName"/>
			</xsl:variable>
			<xsl:variable name="ScannedBarcode">
				<xsl:value-of select="Shipment/Number"/>
			</xsl:variable>

			<xsl:variable name="carrierProductName">
				<xsl:value-of select="substring(translate(Shipment/ProductName, 'abcdefghijklmnopqrstuvwxyzæøåABCDEFGHIJKLMNOPQRSTUVWXYZÆØÅ', 'abcdefghijklmnopqrstuvwxyzæøåABCDEFGHIJKLMNOPQRSTUVWXYZÆØÅ'),5)"/>
			</xsl:variable>
			

			<xsl:variable name="OrderNumber">
				<xsl:value-of select="Shipment/OrderNumber"/>
			</xsl:variable>


			<xsl:variable name="ReceiverName">
				<xsl:value-of select="Shipment/Addresses/Address[child::Kind='Receiver']/Name1" />
			</xsl:variable>


			<xsl:variable name="ReceiverCountryIsoA2">
				<xsl:value-of select="Shipment/Addresses/Address[child::Kind='Receiver']/CountryCode" />
			</xsl:variable>
			<xsl:variable name="ReceiverRef">
				<xsl:value-of select="Shipment/Addresses/Address[child::Kind='Receiver']/ReceiverRef" />
			</xsl:variable>


			<xsl:variable name="ReceiverMobileFull">
				<xsl:value-of select="Shipment/Addresses/Address[child::Kind='Receiver']/Mobile" />
			</xsl:variable>
			<xsl:variable name="ReceiverMobile">
				<xsl:choose>
					<xsl:when test="substring($ReceiverMobileFull,1,1) = '0' and $ReceiverCountryIsoA2 = 'SE' ">
						<xsl:value-of select="translate(substring($ReceiverMobileFull,2), translate(substring($ReceiverMobileFull,2), '0123456789+', ''), '')"/>
					</xsl:when>
					<xsl:when test="substring($ReceiverMobileFull,1,1) = '0' and $ReceiverCountryIsoA2 = 'FI' ">
						<xsl:value-of select="translate(substring($ReceiverMobileFull,2), translate(substring($ReceiverMobileFull,2), '0123456789+', ''), '')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="translate($ReceiverMobileFull,translate($ReceiverMobileFull, '0123456789+', ''), '')"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>


			
			<xsl:variable name="SenderName">
				<xsl:value-of select="Shipment/Addresses/Address[child::Kind='Sender']/Name1" />
			</xsl:variable>
			<xsl:variable name="SenderAdr">
				<xsl:value-of select="Shipment/Addresses/Address[child::Kind='Sender']/Street1" />
			</xsl:variable>
			<xsl:variable name="SenderCity">
				<xsl:value-of select="Shipment/Addresses/Address[child::Kind='Sender']/City" />
			</xsl:variable>
			<xsl:variable name="SenderAttention">
				<xsl:value-of select="Shipment/Addresses/Address[child::Kind='Sender']/Attention" />
			</xsl:variable>
			<xsl:variable name="length" select="string-length($OrderNumber)"/>
			
			<InstallationId>
				<xsl:value-of select="$installationId"/>
			</InstallationId>
			<ActorId>
				<xsl:value-of select="$actorId"/>
			</ActorId>
			<ActorName>
				<xsl:value-of select="$actorName"/>
			</ActorName>
			<LocationId>
				<xsl:value-of select="$locationID"/>
			</LocationId>
			<LocationName>
				<xsl:value-of select="$locationName"/>
			</LocationName>

			

			<xsl:variable name="url">
				<xsl:choose>
					<xsl:when test="$carrierProductName='Naf'">http://web.no/s/301</xsl:when>
					<xsl:when test="$carrierProductName='Oslo Sentrum'">http://web.no/s/301</xsl:when>
					<xsl:when test="$carrierProductName='Forus'">http://web.no/s/302</xsl:when>
					<xsl:when test="$carrierProductName='Alnabru'">http://web.no/s/303</xsl:when>
					<xsl:when test="$carrierProductName='Sandvika'">http://web.no/s/304</xsl:when>
					<xsl:when test="$carrierProductName='Lade'">http://web.no/s/305</xsl:when>
					<xsl:when test="$carrierProductName='Tune'">http://web.no/s/306</xsl:when>
					<xsl:when test="$carrierProductName='Ski'">http://web.no/s/307</xsl:when>
					<xsl:when test="$carrierProductName='Drammen'">http://web.no/s/308</xsl:when>
					<xsl:when test="$carrierProductName='Tiller'">http://web.no/s/309</xsl:when>
					<xsl:when test="$carrierProductName='Lagunen'">http://web.no/s/310</xsl:when>
					<xsl:when test="$carrierProductName='Majorstua'">http://web.no/s/311</xsl:when>
					<xsl:when test="$carrierProductName='Åsane'">http://web.no/s/312</xsl:when>
					<xsl:when test="$carrierProductName='Kristiansand'">http://web.no/s/313</xsl:when>
					<xsl:when test="$carrierProductName='Haugesund'">http://web.no/s/314</xsl:when>
					<xsl:when test="$carrierProductName='Moss'">http://web.no/s/315</xsl:when>
					<xsl:when test="$carrierProductName='Tromsø'">http://web.no/s/316</xsl:when>
					<xsl:when test="$carrierProductName='Ålesund'">http://web.no/s/317</xsl:when>
					<xsl:when test="$carrierProductName='Strømmen'">http://web.no/s/318</xsl:when>
					<xsl:when test="$carrierProductName='Steinkjer'">http://web.no/s/319</xsl:when>
					<xsl:when test="$carrierProductName='Tønsberg'">http://web.no/s/320</xsl:when>
					<xsl:when test="$carrierProductName='Fredrikstad'">http://web.no/s/321</xsl:when>
					<xsl:when test="$carrierProductName='Mo i rana'">http://web.no/s/322</xsl:when>
					<xsl:when test="$carrierProductName='Hamar'">http://web.no/s/323</xsl:when>
					<xsl:when test="$carrierProductName='Bodø'">http://web.no/s/324</xsl:when>
					<xsl:when test="$carrierProductName='Nettlageret'">http://web.no/s/400</xsl:when>
					<xsl:when test="$carrierProductName='Harstad'">http://web.no/s/325</xsl:when>
					<xsl:when test="$carrierProductName='Sandefjord'">http://web.no/s/326</xsl:when>
					<xsl:when test="$carrierProductName='Sartor'">http://web.no/s/327</xsl:when>
					
					<xsl:when test="$carrierProductName='e-commerce'">http://web.se/s/570</xsl:when>					
					<xsl:when test="$carrierProductName='Bromma'">http://web.se/s/501</xsl:when>
					<xsl:when test="$carrierProductName='Arninge'">http://web.se/s/502</xsl:when>
					<xsl:when test="$carrierProductName='Sisjön'">http://web.se/s/503</xsl:when>
					<xsl:when test="$carrierProductName='Bäckebol'">http://web.se/s/504</xsl:when>
					<xsl:when test="$carrierProductName='Örebro'">http://web.se/s/505</xsl:when>
					<xsl:when test="$carrierProductName='Uppsala'">http://web.se/s/506</xsl:when>
					<xsl:when test="$carrierProductName='Kungens kurva'">http://web.se/s/507</xsl:when>
					<xsl:when test="$carrierProductName='Linköping'">http://web.se/s/508</xsl:when>
					<xsl:when test="$carrierProductName='Sundsvall'">http://web.se/s/509</xsl:when>
					<xsl:when test="$carrierProductName='Jönköping'">http://web.se/s/510</xsl:when>
					<xsl:when test="$carrierProductName='Stockholm City'">http://web.se/s/511</xsl:when>
					<xsl:when test="$carrierProductName='Västerås'">http://web.se/s/512</xsl:when>
					<xsl:when test="$carrierProductName='Norrköping'">http://web.se/s/513</xsl:when>
					<xsl:when test="$carrierProductName='Karlstad'">http://web.se/s/514</xsl:when>
					<xsl:when test="$carrierProductName='Helsingborg'">http://web.se/s/515</xsl:when>
					<xsl:when test="$carrierProductName='Barkarby'">http://web.se/s/516</xsl:when>
					<xsl:when test="$carrierProductName='Luleå'">http://web.se/s/517</xsl:when>
					<xsl:when test="$carrierProductName='Gävle'">http://web.se/s/518</xsl:when>
					<xsl:when test="$carrierProductName='Östersund'">http://web.se/s/520</xsl:when>
					<xsl:when test="$carrierProductName='Östersund'">http://web.se/s/519</xsl:when>

					
					<xsl:when test="$carrierProductName='Tammisto'">http://web.fi/s/701</xsl:when>
					<xsl:when test="$carrierProductName='Itäkeskus'">http://web.fi/s/702</xsl:when>
					<xsl:when test="$carrierProductName='Kaleva'">http://web.fi/s/703</xsl:when>
					<xsl:when test="$carrierProductName='Kluuvi'">http://web.fi/s/704</xsl:when>
					<xsl:when test="$carrierProductName='Suomenoja'">http://web.fi/s/705</xsl:when>
					<xsl:when test="$carrierProductName='Lielahti'">http://web.fi/s/706</xsl:when>
					<xsl:when test="$carrierProductName='Skanssi'">http://web.fi/s/707</xsl:when>
					<xsl:when test="$carrierProductName='Mylly'">http://web.fi/s/708</xsl:when>
					<xsl:when test="$carrierProductName='Oulu'">http://web.fi/s/709</xsl:when>
					
					<xsl:otherwise>http://web.no/s/</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

		

          <ReceiverName>
            <xsl:value-of select="$ReceiverName"/>
          </ReceiverName>




			
		</SmsFileInfo>
	</xsl:template>
</xsl:stylesheet>
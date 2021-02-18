//
//  Application.swift
//  covid19
//
//  Created by Stefan Sturm on 01.11.20.
//

import SwiftUI

struct Application {
    struct UI {
        struct Fonts {
            static let header = UIDevice.current.userInterfaceIdiom == .pad ? Font.system(size: 18, weight: .bold, design: .default) : Font.system(size: 17, weight: .semibold, design: .default)
            static let subheader = UIDevice.current.userInterfaceIdiom == .pad ? Font.system(size: 18, weight: .semibold, design: .default) : Font.system(size: 16, weight: .semibold, design: .default)
            static let incident = UIDevice.current.userInterfaceIdiom == .pad ? Font.system(size: 21, weight: .bold, design: .default) : Font.system(size: 19, weight: .bold, design: .default)
            static let valueLabel = UIDevice.current.userInterfaceIdiom == .pad ? Font.system(size: 16, weight: .regular, design: .default) : Font.system(size: 14, weight: .semibold, design: .default)
            static let value = UIDevice.current.userInterfaceIdiom == .pad ? Font.system(size: 17, weight: .regular, design: .default) : Font.system(size: 15, weight: .semibold, design: .default)
        }
    }
    struct Widgets {
        struct Fonts {
            static let header = Font.system(size: 15, weight: .bold, design: .default)
            static let subheader = Font.system(size: 14, weight: .bold, design: .default)
            static let valueLabel = Font.system(size: 14, weight: .regular, design: .default)
            static let value = Font.system(size: 14, weight: .semibold, design: .default)
            static let incident = Font.system(size: 16, weight: .bold, design: .default)
            static let icons = Font.system(size: 16, weight: .regular, design: .default)
        }
    }
    
    struct Settings {
        static let chartMinValue: Int = 45
        static let chartMaxValue: Int = 90
        static let chartRoundedCorner: CGFloat = 2.0
    }
    
    struct Urls {
        // MARK: - Glodal Data URL's
        
        static let globalCasesUrl = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_COVID19/FeatureServer/0/query?f=json&where=NeuerFall%20IN(1,%20-1)&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&outStatistics=%5B%7B%22statisticType%22:%22sum%22,%22onStatisticField%22:%22AnzahlFall%22,%22outStatisticFieldName%22:%22value%22%7D%5D&resultType=standard&cacheHint=true"

        static let globalDeathUrl = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_COVID19/FeatureServer/0/query?f=json&where=NeuerTodesfall%20IN(1,%20-1)&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&outStatistics=%5B%7B%22statisticType%22:%22sum%22,%22onStatisticField%22:%22AnzahlTodesfall%22,%22outStatisticFieldName%22:%22value%22%7D%5D&resultType=standard&cacheHint=true"
        
        static let globalRecoveredHistoryUrl = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/Covid19_RKI_Sums/FeatureServer/0/query?f=json&where=Meldedatum%3Etimestamp%20%272020-03-01%2022:59:59%27&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&groupByFieldsForStatistics=Meldedatum&outStatistics=%5B%7B%22statisticType%22:%22sum%22,%22onStatisticField%22:%22AnzahlGenesen%22,%22outStatisticFieldName%22:%22total%22%7D%5D&resultType=standard&cacheHint=true&orderByFields=Meldedatum%20asc"
        
        static let globalCasesHistoryUrl = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/Covid19_RKI_Sums/FeatureServer/0/query?f=json&where=Meldedatum%3Etimestamp%20%272020-03-01%2022:59:59%27&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&groupByFieldsForStatistics=Meldedatum&orderByFields=Meldedatum%20asc&outStatistics=%5B%7B%22statisticType%22:%22sum%22,%22onStatisticField%22:%22AnzahlFall%22,%22outStatisticFieldName%22:%22total%22%7D%5D&resultType=standard&cacheHint=true"
        
        static let globalDeathsHistoryUrl = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/Covid19_RKI_Sums/FeatureServer/0/query?f=json&where=Meldedatum%3Etimestamp%20%272020-03-01%2022:59:59%27&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&groupByFieldsForStatistics=Meldedatum&orderByFields=Meldedatum%20asc&outStatistics=%5B%7B%22statisticType%22:%22sum%22,%22onStatisticField%22:%22AnzahlTodesfall%22,%22outStatisticFieldName%22:%22total%22%7D%5D&resultType=standard&cacheHint=true"

        static let globalIntensivListUrl = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/DIVI_Intensivregister_Landkreise/FeatureServer/0/query?where=1%3D1&outFields=OBJECTID,BL,BL_ID,county,anzahl_standorte,anzahl_meldebereiche,betten_frei,betten_belegt,betten_gesamt,Anteil_betten_frei,faelle_covid_aktuell,faelle_covid_aktuell_beatmet,Anteil_covid_beatmet,Anteil_COVID_betten,daten_stand&returnGeometry=false&outSR=4326&f=json"

        // MARK: - Province Data URL's

        static let proviceCasesUrl = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_COVID19/FeatureServer/0/query?f=json&where=NeuerFall%20IN(1,%20-1)&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&outStatistics=%5B%7B%22statisticType%22:%22sum%22,%22onStatisticField%22:%22AnzahlFall%22,%22outStatisticFieldName%22:%22value%22%7D%5D&resultType=standard&cacheHint=true&groupByFieldsForStatistics=Bundesland"

        static let proviceDeathUrl = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_COVID19/FeatureServer/0/query?f=json&where=NeuerTodesfall%20IN(1,%20-1)&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&outStatistics=%5B%7B%22statisticType%22:%22sum%22,%22onStatisticField%22:%22AnzahlTodesfall%22,%22outStatisticFieldName%22:%22value%22%7D%5D&resultType=standard&cacheHint=true&groupByFieldsForStatistics=Bundesland"

        static let provinceListUrl = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/Coronaf%C3%A4lle_in_den_Bundesl%C3%A4ndern/FeatureServer/0/query?where=1%3D1&outFields=OBJECTID_1,LAN_ew_GEN,LAN_ew_EWZ,Fallzahl,Aktualisierung,faelle_100000_EW,Death,cases7_bl_per_100k&returnGeometry=false&f=json"
        
        static let provinceRecoveredUrl = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/Covid19_RKI_Sums/FeatureServer/0/query?f=json&where=Meldedatum%3Etimestamp%20%272020-03-01%2022:59:59%27&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&groupByFieldsForStatistics=Bundesland&outStatistics=%5B%7B%22statisticType%22:%22sum%22,%22onStatisticField%22:%22AnzahlGenesen%22,%22outStatisticFieldName%22:%22value%22%7D%5D&resultType=standard&cacheHint=true"

        static let provinceCasesHistoryUrl = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/Covid19_RKI_Sums/FeatureServer/0/query?f=json&where=Meldedatum%3Etimestamp%20%272020-03-01%2022:59:59%27%20AND%20Bundesland%20%3D%20%27%@%27&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&groupByFieldsForStatistics=Meldedatum&orderByFields=Meldedatum%20asc&outStatistics=%5B%7B%22statisticType%22:%22sum%22,%22onStatisticField%22:%22AnzahlFall%22,%22outStatisticFieldName%22:%22total%22%7D%5D&resultType=standard&cacheHint=true"

        static let provinceDeathsHistoryUrl = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/Covid19_RKI_Sums/FeatureServer/0/query?f=json&where=Meldedatum%3Etimestamp%20%272020-03-01%2022:59:59%27%20AND%20Bundesland%20%3D%20%27%@%27&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&groupByFieldsForStatistics=Meldedatum&orderByFields=Meldedatum%20asc&outStatistics=%5B%7B%22statisticType%22:%22sum%22,%22onStatisticField%22:%22AnzahlTodesfall%22,%22outStatisticFieldName%22:%22total%22%7D%5D&resultType=standard&cacheHint=true"

        static let provinceRecoveredHistoryUrl = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/Covid19_RKI_Sums/FeatureServer/0/query?f=json&where=Meldedatum%3Etimestamp%20%272020-03-01%2022:59:59%27%20AND%20Bundesland%20%3D%20%27%@%27&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&groupByFieldsForStatistics=Meldedatum&orderByFields=Meldedatum%20asc&outStatistics=%5B%7B%22statisticType%22:%22sum%22,%22onStatisticField%22:%22AnzahlGenesen%22,%22outStatisticFieldName%22:%22total%22%7D%5D&resultType=standard&cacheHint=true"
        
        // MARK: - County Data URL's

        static let countyCasesUrl = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_COVID19/FeatureServer/0/query?f=json&where=NeuerFall%20IN(1,%20-1)&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&outStatistics=%5B%7B%22statisticType%22:%22sum%22,%22onStatisticField%22:%22AnzahlFall%22,%22outStatisticFieldName%22:%22value%22%7D%5D&resultType=standard&cacheHint=true&groupByFieldsForStatistics=Landkreis"

        static let countyDeathUrl = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_COVID19/FeatureServer/0/query?f=json&where=NeuerTodesfall%20IN(1,%20-1)&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&outStatistics=%5B%7B%22statisticType%22:%22sum%22,%22onStatisticField%22:%22AnzahlTodesfall%22,%22outStatisticFieldName%22:%22value%22%7D%5D&resultType=standard&cacheHint=true&groupByFieldsForStatistics=Landkreis"

        static let countyListUrl = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?where=1%3D1&outFields=OBJECTID,GEN,AGS,BEZ,EWZ,KFL,death_rate,cases,deaths,cases_per_100k,cases_per_population,BL,BL_ID,county,last_update,cases7_per_100k,recovered,EWZ_BL,cases7_bl_per_100k&returnGeometry=false&outSR=4326&f=json"
            
        static let countyRecoveredUrl = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/Covid19_RKI_Sums/FeatureServer/0/query?f=json&where=Meldedatum%3Etimestamp%20%272020-03-01%2022:59:59%27&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&groupByFieldsForStatistics=Landkreis&outStatistics=%5B%7B%22statisticType%22:%22sum%22,%22onStatisticField%22:%22AnzahlGenesen%22,%22outStatisticFieldName%22:%22value%22%7D%5D&resultType=standard&cacheHint=true"
        
        static let countyCasesHistoryUrl = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/Covid19_RKI_Sums/FeatureServer/0/query?f=json&where=Meldedatum%3Etimestamp%20%272020-03-01%2022:59:59%27%20AND%20Landkreis%20%3D%20%27%@%27&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&groupByFieldsForStatistics=Meldedatum&orderByFields=Meldedatum%20asc&outStatistics=%5B%7B%22statisticType%22:%22sum%22,%22onStatisticField%22:%22AnzahlFall%22,%22outStatisticFieldName%22:%22total%22%7D%5D&resultType=standard&cacheHint=true"
        
        static let countyDeathsHistoryUrl = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/Covid19_RKI_Sums/FeatureServer/0/query?f=json&where=Meldedatum%3Etimestamp%20%272020-03-01%2022:59:59%27%20AND%20Landkreis%20%3D%20%27%@%27&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&groupByFieldsForStatistics=Meldedatum&orderByFields=Meldedatum%20asc&outStatistics=%5B%7B%22statisticType%22:%22sum%22,%22onStatisticField%22:%22AnzahlTodesfall%22,%22outStatisticFieldName%22:%22total%22%7D%5D&resultType=standard&cacheHint=true"
        
        static let countyRecoveredHistoryUrl = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/Covid19_RKI_Sums/FeatureServer/0/query?f=json&where=Meldedatum%3Etimestamp%20%272020-03-01%2022:59:59%27%20AND%20Landkreis%20%3D%20%27%@%27&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&groupByFieldsForStatistics=Meldedatum&orderByFields=Meldedatum%20asc&outStatistics=%5B%7B%22statisticType%22:%22sum%22,%22onStatisticField%22:%22AnzahlGenesen%22,%22outStatisticFieldName%22:%22total%22%7D%5D&resultType=standard&cacheHint=true"
        
        static let impfHistoryUrl = "https://services.arcgis.com/OLiydejKCZTGhvWg/arcgis/rest/services/Impftabelle_mit_Zweitimpfungen/FeatureServer/0/query?f=json&where=1%3D1&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&orderByFields=Datenstand%20asc&outSR=102100&resultOffset=0&resultRecordCount=32000&resultType=standard&cacheHint=true"
    }
}

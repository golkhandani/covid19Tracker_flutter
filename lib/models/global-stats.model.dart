// To parse this JSON data, do
//
//     final globalStats = globalStatsFromJson(jsonString);

import 'dart:convert';

class GlobalStats {
    List<GlobalStatsResult> results;
    String stat;

    GlobalStats({
        this.results,
        this.stat,
    });

    factory GlobalStats.fromJson(String str) => GlobalStats.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GlobalStats.fromMap(Map<String, dynamic> json) => GlobalStats(
        results: json["results"] == null ? null : List<GlobalStatsResult>.from(json["results"].map((x) => GlobalStatsResult.fromMap(x))),
        stat: json["stat"] == null ? null : json["stat"],
    );

    Map<String, dynamic> toMap() => {
        "results": results == null ? null : List<dynamic>.from(results.map((x) => x.toMap())),
        "stat": stat == null ? null : stat,
    };
}

class GlobalStatsResult {
    int totalCases;
    int totalRecovered;
    int totalUnresolved;
    int totalDeaths;
    int totalNewCasesToday;
    int totalNewDeathsToday;
    int totalActiveCases;
    int totalSeriousCases;
    int totalAffectedCountries;
    Source source;

    GlobalStatsResult({
        this.totalCases,
        this.totalRecovered,
        this.totalUnresolved,
        this.totalDeaths,
        this.totalNewCasesToday,
        this.totalNewDeathsToday,
        this.totalActiveCases,
        this.totalSeriousCases,
        this.totalAffectedCountries,
        this.source,
    });

    factory GlobalStatsResult.fromJson(String str) => GlobalStatsResult.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GlobalStatsResult.fromMap(Map<String, dynamic> json) => GlobalStatsResult(
        totalCases: json["total_cases"] == null ? null : json["total_cases"],
        totalRecovered: json["total_recovered"] == null ? null : json["total_recovered"],
        totalUnresolved: json["total_unresolved"] == null ? null : json["total_unresolved"],
        totalDeaths: json["total_deaths"] == null ? null : json["total_deaths"],
        totalNewCasesToday: json["total_new_cases_today"] == null ? null : json["total_new_cases_today"],
        totalNewDeathsToday: json["total_new_deaths_today"] == null ? null : json["total_new_deaths_today"],
        totalActiveCases: json["total_active_cases"] == null ? null : json["total_active_cases"],
        totalSeriousCases: json["total_serious_cases"] == null ? null : json["total_serious_cases"],
        totalAffectedCountries: json["total_affected_countries"] == null ? null : json["total_affected_countries"],
        source: json["source"] == null ? null : Source.fromMap(json["source"]),
    );

    Map<String, dynamic> toMap() => {
        "total_cases": totalCases == null ? null : totalCases,
        "total_recovered": totalRecovered == null ? null : totalRecovered,
        "total_unresolved": totalUnresolved == null ? null : totalUnresolved,
        "total_deaths": totalDeaths == null ? null : totalDeaths,
        "total_new_cases_today": totalNewCasesToday == null ? null : totalNewCasesToday,
        "total_new_deaths_today": totalNewDeathsToday == null ? null : totalNewDeathsToday,
        "total_active_cases": totalActiveCases == null ? null : totalActiveCases,
        "total_serious_cases": totalSeriousCases == null ? null : totalSeriousCases,
        "total_affected_countries": totalAffectedCountries == null ? null : totalAffectedCountries,
        "source": source == null ? null : source.toMap(),
    };
}

class Source {
    String url;

    Source({
        this.url,
    });

    factory Source.fromJson(String str) => Source.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Source.fromMap(Map<String, dynamic> json) => Source(
        url: json["url"] == null ? null : json["url"],
    );

    Map<String, dynamic> toMap() => {
        "url": url == null ? null : url,
    };
}

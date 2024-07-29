# COVID-19データ探索と可視化
## プロジェクト概要
このプロジェクトは、COVID-19のデータ、特に全世界の死亡者数とワクチン接種統計に焦点を当てて分析することを目的としています。データは[Our World in Data](https://ourworldindata.org/covid-deaths) から取得し、2つのデータセット（COVID-19 DeathsおよびCOVID-19 Vaccinations）を使用しました。分析はSQL Serverを用いて行い、結果はTableauで可視化しました。

## データソース
- **COVID-19 Deaths:** [ダウンロードリンク](https://ourworldindata.org/covid-deaths)
- **COVID-19 Vaccinations:** [ダウンロードリンク](https://ourworldindata.org/covid-deaths)
## ツールと技術
- **SQL Server:** データ分析とクエリ用
- **Tableau:** データ可視化用
- **GitHub:** SQLクエリの保存とプロジェクトドキュメントの共有用
## SQL分析
データ探索と分析に使用したSQLクエリは、私のGitHubリポジトリにあります。[GitHub repository](https://github.com/DiepKhuat/PortfolioProjects/blob/main/COVID%20Portfolio%20Project%20-%20SQL%20Data%20Exploration.sql).

### 主なSQLクエリ
1. **国別の総死亡者数::**

```sql
SELECT location, SUM(new_deaths) AS total_deaths
FROM covid_deaths
GROUP BY location
ORDER BY total_deaths DESC;
```
2. **国別のワクチン接種率:**

```sql
SELECT location, MAX(total_vaccinations) AS total_vaccinations, MAX(population) AS population, 
       (MAX(total_vaccinations) / MAX(population)) * 100 AS vaccination_rate
FROM covid_vaccinations
GROUP BY location
ORDER BY vaccination_rate DESC;
```
3. **月別死亡者数の推移:**

```sql
SELECT DATEPART(YEAR, date) AS year, DATEPART(MONTH, date) AS month, SUM(new_deaths) AS total_deaths
FROM covid_deaths
GROUP BY DATEPART(YEAR, date), DATEPART(MONTH, date)
ORDER BY year, month;
```
## データ可視化
Tableauで作成した可視化には以下が含まれます:

- **世界の死亡者数とワクチン接種の概要:**  国別の総死亡者数とワクチン接種数を要約したダッシュボード
- **月別死亡者数の推移:** 死亡者数の時間的推移を示す折れ線グラフ
- **ワクチン接種率の比較:**  国別のワクチン接種率を比較する棒グラフ
Tableauダッシュボードはこちらからご覧いただけます。 [here](https://public.tableau.com/app/profile/diep.khuat/viz/CovidDashboard_17192173893080/Dashboard1).

### 発見
1. **総死亡者数:** 死亡者数が最も多い国はアメリカ合衆国、ブラジル、インドです。
2. **ワクチン接種率:** ワクチン接種率が最も高い国にはアラブ首長国連邦、マルタ、イスラエルが含まれます。
3. **月別トレンド:** 2021年初頭に死亡者数が大幅に増加しました。

### 結論
この分析と可視化は、COVID-19がさまざまな地域に与える影響とワクチン接種の進捗状況について貴重な洞察を提供します。これらの発見は、公衆衛生の意思決定やパンデミックに対抗するための戦略策定に役立つでしょう。

## 今後の作業
- **データの更新**: 最新のCOVID-19統計を反映するためにデータを継続的に更新する。
- **詳細分析**: ワクチン接種率と死亡率の減少との相関についてより詳細な分析を行う。
- **予測モデル**: COVID-19のケースと死亡者数の将来の傾向を予測するためのモデルを開発する。

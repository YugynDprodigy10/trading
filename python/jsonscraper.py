#!/usr/bin/python
'''
WebScraper
'''
import logging
import json
from web_tools import json_scraper

def main():
	name = "WebScraper"
	print (name)
	logging.basicConfig(format='%(asctime)s [%(levelname)s] %(message)s', filename='jsonscraper.log',level=logging.DEBUG)
	logging.debug("%s Started", name)
	scrape = json_scraper.JSONScraper("https://query1.finance.yahoo.com/v10/finance/quoteSummary/YHOO?formatted=true&crumb=GfcEejc1sYm&lang=en-GB&region=GB&modules=defaultKeyStatistics%2CfinancialData%2CcalendarEvents&corsDomain=uk.finance.yahoo.com")
	scrape.initialise()
	scrape.run()
	json_data= scrape.fetch_json()
	result = json_data["quoteSummary"]["result"]

	financial_data = (
		"returnOnEquity",
		"totalRevenue",
		"maxAge",
		"targetLowPrice",
		"currentPrice",
		"ebitda",
		"currentRatio",
		"numberOfAnalystOpinions",
		"revenuePerShare",
		"freeCashflow",
		"totalCashPerShare",
		"operatingMargins",
		"returnOnAssets",
		"ebitdaMargins",
		"targetMedianPrice",
		"totalDebt",
		"targetHighPrice",
		"totalCash",
		"recommendationKey",
		"grossMargins",
		"grossProfits",
		"targetMeanPrice",
		"debtToEquity",
		"profitMargins",
		"operatingCashflow",
		"recommendationMean",
		"earningsGrowth",
		"revenueGrowth",
		"quickRatio"
	)

	default_key_statistics = ("returnOnEquity",
		"totalRevenue",
		"maxAge",
		"targetLowPrice",
		"currentPrice",
		"ebitda",
		"currentRatio",
		"numberOfAnalystOpinions",
		"revenuePerShare",
		"freeCashflow",
		"totalCashPerShare",
		"operatingMargins",
		"returnOnAssets",
		"ebitdaMargins",
		"targetMedianPrice",
		"totalDebt",
		"targetHighPrice",
		"totalCash",
		"recommendationKey",
		"grossMargins",
		"grossProfits",
		"targetMeanPrice",
		"debtToEquity",
		"profitMargins",
		"operatingCashflow",
		"recommendationMean",
		"earningsGrowth",
		"revenueGrowth",
		"quickRatio"
	)

	# calendarEvents, V: {u'dividendDate': {}, u'exDividendDate': {}, u'maxAge': 1, u'earnings': {u'earningsAverage': {u'raw': 0.21, u'fmt': u'0.21'}, u'revenueAverage': {u'raw': 1383790000, u'fmt': u'1.38B', u'longFmt': u'1,383,790,000'}, u'earningsLow': {u'raw': 0.11, u'fmt': u'0.11'}, u'earningsHigh': {u'raw': 0.26, u'fmt': u'0.26'}, u'revenueLow': {u'raw': 1353000000, u'fmt': u'1.35B', u'longFmt': u'1,353,000,000'}, u'earningsDate': [{u'raw': 1485820800, u'fmt': u'2017-01-31'}, {u'raw': 1486339200, u'fmt': u'2017-02-06'}], u'revenueHigh': {u'raw': 1406410000, u'fmt': u'1.41B', u'longFmt': u'1,406,410,000'}}}

	#logging.info("quote_summary = %s", result)
	for r in result:
		#logging.critical("FRRREr = %s", r)
		for k,v in r.iteritems():
			logging.debug("K: %s, V: %s", k,v)
			for fin, mon in v.iteritems():
				if fin in default_key_statistics:
					logging.debug("FIN: %s, VALUE: %s", fin, mon)
					dr = json.loads(mon)
					for t,v in mon.iteritems():
						logging.debug(    "F_TYPE:%s value:%s", t,v)
	scrape.shutdown()
	print("Exiting...")

# Assign a start point to the executable
if __name__ == "__main__":
	main()

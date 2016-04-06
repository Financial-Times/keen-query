.PHONY: test

test-query:
	node ./bin/keen-query.js 'cta:click->count(user.uuid)->relTime(3)'
	node ./bin/keen-query.js 'cta:click->count()->filter(user.uuid)->relTime(3)'
	node ./bin/keen-query.js 'cta:click->count()->filter(user.uuid!?12,11,14)->interval(2_d)->relTime(6)';
	node ./bin/keen-query.js 'cta:click->count()->filter(user.uuid)->interval(d)->group(page.location.type)->relTime(3)';
	node ./bin/keen-query.js 'cta:click->count()->filter(user.uuid)->interval(day)->group(page.location.type)->relTime(3)';
	node ./bin/keen-query.js 'cta:click->count()->filter(user.uuid)->group(page.location.type,user.isStaff)->relTime(3)';
	node ./bin/keen-query.js 'cta:click->count()->filter(user.uuid)->group(page.location.type,user.isStaff)->relTime(3)->round()';
	node ./bin/keen-query.js 'cta:click->count()->filter(user.uuid)->interval(2_d)->relTime(6)';
	node ./bin/keen-query.js 'cta:click->count(user.uuid)->relTime(3)->filter(user.uuid!~f0bb6f11)'

test-trim:
	node ./bin/keen-query.js 'cta:click->count(user.uuid)->relTime(3)'
	node ./bin/keen-query.js 'cta:click -> count (user.uuid) -> relTime(3)'
	node ./bin/keen-query.js ' @ratio ( cta:click -> count (user.uuid) -> relTime(3) , cta:click -> count (user.uuid) -> relTime(3) ) ->interval(d)'

test-ratio:
	node ./bin/keen-query.js '@ratio(cta:click->count(),cta:click->count(user.uuid))->relTime(3)'
	node ./bin/keen-query.js '@ratio(cta:click->count(),cta:click->count(user.uuid))->interval(d)->relTime(3)'
	node ./bin/keen-query.js '@ratio(cta:click->count(),cta:click->count(user.uuid))->interval(d)->group(page.location.type)->relTime(3)'
	node ./bin/keen-query.js '@ratio(cta:click->count(),cta:click->count(user.uuid))->group(page.location.type,user.isStaff)->relTime(3)'
	node ./bin/keen-query.js '@ratio(cta:click->count()->group(page.location.type,user.isStaff),cta:click->count(user.uuid)->group(page.location.type))->relTime(3)'

test-concat:
	node ./bin/keen-query.js '@concat(cta:click->count(),cta:click->count(user.uuid),page:view->count(user.uuid))->relTime(3)'
	node ./bin/keen-query.js '@concat(cta:click->count()->group(page.location.type),cta:click->count(user.uuid),page:view->count(user.uuid))->relTime(3)'
	node ./bin/keen-query.js '@concat(cta:click->count(),cta:click->count(user.uuid),page:view->count(user.uuid))->group(page.location.type)->relTime(3)'
	node ./bin/keen-query.js '@concat(cta:click->count()->group(user.isStaff),cta:click->count(user.uuid),page:view->count(user.uuid))->group(page.location.type)->relTime(3)'
	node ./bin/keen-query.js '@concat(cta:click->count(),cta:click->count(user.uuid))->interval(d)->relTime(3)'
	node ./bin/keen-query.js '@concat(cta:click->count()->group(page.location.type),cta:click->count(user.uuid))->interval(d)->relTime(3)'
	node ./bin/keen-query.js '@concat(@pct(site:optout->count(user.uuid),page:view->count(user.uuid)), @pct(site:optin->count(user.uuid)->filter(context.optedVia!=__anon-opt-in)->filter(context.optedVia!=__m-dot-opt-in),page:view->count(user.uuid)))->interval(d)'
	# node ./bin/keen-query.js '@concat(page:view->count(user.uuid)->interval(day)->relTime(this_3_days),page:view->count(user.uuid)->filter(user.myft.isMyFtUser=true)->interval(day)->relTime(this_3_days))';
	# node ./bin/keen-query.js '@concat(cta:click->count(),cta:click->count(user.uuid))->interval(d)->relTime(3)'
	# node ./bin/keen-query.js '@concat(cta:click->count(),cta:click->count(user.uuid))->interval(d)->group(page.location.type)->relTime(3)'
	# node ./bin/keen-query.js '@concat(cta:click->count(),cta:click->count(user.uuid))->group(page.location.type,user.isStaff)->relTime(3)'

test-funnel:
	node ./bin/keen-query.js '@funnel(page:view->count(),cta:click->count())->relTime(3)'
	node ./bin/keen-query.js '@funnel(page:view->count(user.uuid)->filter(page.location.type=frontpage),page:view->count(user.uuid)->filter(page.location.type=article)->filter(page.referrer.type=frontpage),page:view->count(user.uuid)->filter(page.location.type=article)->filter(page.referrer.type=article))->relTime(3)->with(user.uuid)'

test-reduce:
	node ./bin/keen-query.js 'cta:click->count()->interval(d)->relTime(3)->reduce(avg)'
	node ./bin/keen-query.js 'cta:click->count()->interval(d)->group(page.location.type)->relTime(3)'
	node ./bin/keen-query.js 'cta:click->count(user.uuid)->interval(d)->group(page.location.type)->relTime(3)->reduce(all)'
	node ./bin/keen-query.js '@ratio(cta:click->count(),cta:click->count(user.uuid))->interval(d)->group(page.location.type)->relTime(3)'
	node ./bin/keen-query.js '@ratio(cta:click->count(),cta:click->count(user.uuid))->interval(d)->group(page.location.type)->relTime(3)->reduce(avg)'

test-multiply-concat:
	node ./bin/keen-query.js '@concat(cta:click->count()->multiply(1000),cta:click->count())->relTime(3)'

test-threshold:
	node ./bin/keen-query.js 'cta:click->count()->group(page.location.type)->interval(d)->relTime(3)->threshold(5000,minimumlevel)'

test-select:
	node ./bin/keen-query.js 'cta:click->select(page.location.type)->relTime(30_minutes)'
	node ./bin/keen-query.js 'cta:click->select(page.location.type)->relTime(30_minutes)->group(user.isStaff)'
	node ./bin/keen-query.js 'cta:click->select(page.location.type)->relTime(30_minutes)->interval(m)'
	node ./bin/keen-query.js 'cta:click->select(page.location.type)->relTime(30_minutes)->interval(m)->group(user.isStaff)'

test-sort:
	node ./bin/keen-query.js 'page:view->count()->group(page.location.type,device.oGridLayout)->relTime(3)->sortDesc(min,device.oGridLayout)'
	node ./bin/keen-query.js 'page:view->count(user.uuid)->group(device.oGridLayout)->sortProp(device.oGridLayout,default,XS,S,M,L,XL,XXL)'
	node ./bin/keen-query.js 'page:view->count(user.uuid)->group(device.oGridLayout)->interval(d)->sortProp(device.oGridLayout,default,XS,S,M,L,XL,XXL)'
	node ./bin/keen-query.js 'page:view->count(user.uuid)->group(device.oGridLayout)->group(page.location.type)->sortProp(device.oGridLayout,default,XS,S,M,L,XL,XXL)'
	# node ./bin/keen-query.js 'cta:click->count()->group(page.location.type)->relTime(3)->sortAsc()'
	# node ./bin/keen-query.js 'cta:click->count(user.uuid)->interval(d)->group(page.location.type)->relTime(3)->reduce(all)'
	# node ./bin/keen-query.js '@ratio(cta:click->count(),cta:click->count(user.uuid))->interval(d)->group(page.location.type)->relTime(3)'
	# node ./bin/keen-query.js '@ratio(cta:click->count(),cta:click->count(user.uuid))->interval(d)->group(page.location.type)->relTime(3)->reduce(avg)'


test-cutoff:
	node ./bin/keen-query.js 'cta:click->count()->filter(user.uuid)->group(page.location.type)->relTime(3)->top(2)'
	node ./bin/keen-query.js 'cta:click->count()->filter(user.uuid)->group(page.location.type)->relTime(3)->top(20,percent)'
	node ./bin/keen-query.js 'cta:click->count()->filter(user.uuid)->group(page.location.type)->relTime(3)->bottom(2)'
	node ./bin/keen-query.js 'cta:click->count()->filter(user.uuid)->group(page.location.type)->relTime(3)->bottom(20,percent)'
	node ./bin/keen-query.js 'cta:click->count()->filter(user.uuid)->group(page.location.type)->relTime(3)->cutoff(10000)'

test-reusability:
	mocha test/reusability.test.js

test-keen-urls:
	mocha test/keen-urls.test.js

test-err:
	node ./bin/keen-query.js '@pct(site:optout->count(user.uuid)->group(device.oGridLayout),page:view->count(user.uuid)->group(device.oGridLayout)->filter(device.oGridLayout?L,M))->round()->interval(d)'

install:
	npm install

test:
	@echo \(Note: Use \`make test-all\` for comprehensive testing\)
	nbt verify --skip-layout-checks

test-now:
	node ./bin/keen-query.js 'page:view->count(user.uuid)->group(device.oGridLayout)->sortProp(device.oGridLayout,default,XS,S,M,L,XL,XXL)->relabel(device.oGridLayout,chicken,pizza)'

test-all:
	make test-err test-keen-urls test-reusability test-cutoff test-sort test-select test-threshold test-reduce test-funnel test-concat test-ratio test-trim test-query


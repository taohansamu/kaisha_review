var app = angular.module('mainApp',[]);
app.config(["$httpProvider", function ($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}

]);
app.service('companies', ['$http', companiesService]);
app.service('reviews', ['$http', reviewsService]);
app.controller('HomeCtrl', ['$scope', 'companies', homeController]);
app.controller('CompanyCtrl', ['$scope', 'reviews', companyController]);

function homeController($scope, companies) {
    $scope.status;
    $scope.companies;
    $scope.page = 1;
    getCompanies($scope.page);

    function getCompanies(page) {
        companies.getCompaniesByPage(page)
            .then(function (response) {
                $scope.companies = response.data;
                console.log(response)
            }, function (error) {
                $scope.status = 'Unable to load companies data' + error;
                console.log(error);
            })
    }

    $scope.showMore = function () {
        $scope.page++;
        companies.getCompaniesByPage($scope.page)
            .then(function (response) {
                $scope.companies = $scope.companies.concat(response.data);
            }, function (error) {
                $scope.status = 'No more' + error;
            })
    }
    $scope.deleteCompany = function (index) {

        if (confirm("sure to delete")) {

            companies.deleteCompany($scope.companies[index].id)
                .then(function () {
                    // getCompanies($scope.page)
                    $scope.companies.splice(index, 1);
                }, function (error) {
                    console.log(error);
                })
        }
    }
}

function companyController($scope, reviews) {
    $scope.init = function (company_id) {
        $scope.company_id = company_id;
        $scope.reviews;
        $scope.page = 1;
        getReviews($scope.company_id, $scope.page);
        getCurrentReview($scope.company_id);

        function getCurrentReview(company_id) {
            reviews.getCurrentReview(company_id)
                .then(function (response) {
                    $scope.current_review = response.data;
                    console.log(response.data);
                }, function (error) {
                    console.log(error);
                })
        }

        function getReviews(company_id, page) {

            reviews.getReviews(company_id, page)
                .then(function (response) {
                    $scope.reviews = response.data;
                }, function (error) {
                    $scope.status = 'Unable to load reviews data' + error;
                    console.log(error);
                })
        }
    }

    $scope.range = function (min, max, step) {
        step = step || 1;
        var input = [];
        for (var i = min; i <= max; i += step) {
            input.push(i);
        }
        return input;
    };
    $scope.createReview = function () {
        var review = {};
        var review_form = $('#review_form').serializeArray().reduce(function (obj, item) {
            obj[item.name] = item.value;
            return obj;
        }, {});
        review.company_id = $scope.company_id;
        review.comment = review_form.comment;
        review.workspace_rate = review_form.workspace_rate;
        review.salary_rate = review_form.salary_rate;
        review.care_rate = review_form.care_rate;
        review.summary_rate = review_form.summary_rate;

        if (!$scope.current_review) {
            reviews.createReview(review, $scope.company_id)
                .then(function (response) {
                    $scope.current_review = response.data;
                    console.log(response.data);
                }, function (error) {
                    console.log(error);
                })
        }
        else {
            reviews.updateReview(review, $scope.company_id)
                .then(function (response) {
                    $scope.current_review = response.data;
                    // Notification.success('DM');
                    $.notify('I will not close until my delay is up.', {
                        placement: {
                            from: 'bottom',
                            align: 'left'
                        }
                    });
                    $scope.current_review = response.data;
                }, function (error) {
                    console.log(error);
                })
        }
    }
}

function reviewsService($http) {
    var urlBase = '/companies';
    this.getCurrentReview = function (companyId) {
        return $http.get(urlBase + '/' + companyId + '/reviews/current_review', {
            params: {company_id: companyId}
        });
    }
    this.getReviews = function (companyId, page) {
        return $http.get(urlBase + '/' + companyId + '/reviews', {
            params: {company_id: companyId, page: page}
        });
    }
    this.createReview = function (review, company_id) {
        return $http.post(urlBase + '/' + company_id + '/reviews', review);
    }
    this.updateReview = function (review, company_id) {
        return $http.put(urlBase + '/' + company_id + '/reviews' + '/' + review.id, review);
    };
    this.deleteReview = function (id, company_id) {
        return $http.delete(urlBase + '/' + id + '.json');
    };
}

function companiesService($http) {
    var urlBase = '/companies'
    this.getCompanies = function () {
        return $http.get(urlBase, {
            params: {page: $scope.page}
        });
    };
    this.getCompaniesByPage = function (page) {
        return $http.get(urlBase, {
            params: {page: page}
        });
    };

    this.getCompany = function (id) {
        return $http.get(urlBase + '/' + id);
    };

    this.insertCompany = function (cust) {
        return $http.post(urlBase, cust);
    };

    this.updateCompany = function (cust) {
        return $http.put(urlBase + '/' + cust.ID, cust)
    };

    this.deleteCompany = function (id) {
        return $http.delete(urlBase + '/' + id + '.json');
    };

    this.getOrders = function (id) {
        return $http.get(urlBase + '/' + id + '/orders');
    };
}
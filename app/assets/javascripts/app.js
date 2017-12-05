var app = angular.module('mainApp', []);
app.config(["$httpProvider", function ($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}

]);
app.service('companies', ['$http', companiesService]);
app.service('reviews', ['$http', reviewsService]);
app.service('relationships', ['$http', relationshipsService]);
app.controller('HomeCtrl', ['$scope', '$location','$timeout','companies', homeController]);
app.controller('CompanyCtrl', ['$scope', 'reviews', 'relationships', companyController]);
app.controller('RateCtrl', ['$scope', rateController]);
app.controller('FollowingCtrl', ['$scope', 'relationships', followingController])
function homeController($scope, $location,$timeout, companies) {
    $scope.status;
    $scope.companies;
    $scope.page = 1;
    $timeout(function(){
        // terms = $location.search();
        // debugger
        terms = new URLSearchParams(window.location.search)
        getCompanies($scope.page, terms.get('term'));
    }, 500)


    function getCompanies(page, term) {
        companies.getCompaniesByPage(page, term)
            .then(function (response) {
                $scope.companies = response.data;
                //console.log(response)
            }, function (error) {
                $scope.status = 'Unable to load companies data' + error;
                //console.log(error);
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
                    ////console.log(error);
                })
        }
    }
}

function companyController($scope, reviews, relationships) {
    $scope.init = function (company_id, relationship_id) {
        $scope.relationship_id = relationship_id;
        $scope.company_id = company_id;
        $scope.reviews;
        $scope.page = 1;
        $scope.errors = null;
        getReviews($scope.company_id, $scope.page);
        getCurrentReview($scope.company_id);
        function getCurrentReview(company_id) {
            reviews.getCurrentReview(company_id)
                .then(function (response) {
                    $scope.current_review = response.data;
                    //console.log(response.data);
                }, function (error) {
                    //console.log(error);
                })
        }

        function getReviews(company_id, page) {

            reviews.getReviews(company_id, page)
                .then(function (response) {
                    $scope.reviews = response.data;
                }, function (error) {
                    $scope.status = 'Unable to load reviews data' + error;
                    //console.log(error);
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
        $scope.success = false;
        var review = {};
        var review_form = $('#review_form').serializeArray().reduce(function (obj, item) {
            review[item.name]=obj[item.name] = item.value;
            return obj;
        }, {});
        review.company_id = $scope.company_id;
        // review.comment = review_form.comment;
        // review.workspace_rate = review_form.workspace_rate;
        // review.salary_rate = review_form.salary_rate;
        // review.care_rate = review_form.care_rate;
        // review.summary_rate = review_form.summary_rate;
        // review.title = review_form.title;
        if (!$scope.current_review) {
            console.log('create review');
            reviews.createReview(review, $scope.company_id)
                .then(function (response) {
                    $scope.errors = null;
                    $scope.success = true;
                    $scope.current_review = response.data;
                    //console.log(response.data);
                }, function (error) {
                    $scope.errors = error.data;
                    //console.log(error);
                })
        }
        else {
            console.log('update review')
            reviews.updateReview(review, $scope.company_id)
                .then(function (response) {
                    $scope.errors = null;
                    $scope.success = false;
                    // debugger
                    $scope.current_review = response.data;

                    $scope.success = true;
                    $scope.current_review = response.data;
                }, function (error) {
                    $scope.errors = error.data;
                    //console.log(error);
                })
        }
    }
    $scope.deleteReview = function () {
        if (confirm("sure to delete")) {
            reviews.deleteReview($scope.current_review.id, $scope.company_id)
                .then(function () {
                    // $('.stars').attr('data-rating',0);
                    delete $scope.current_review;
                }, function (errors) {
                    //console.log(errors.data);
                })
        }
    }
    $scope.follow = function () {
        relationships.createRelationships({ followed_id: $scope.company_id})
            .then(function (response) {
                //console.log(response.data);
                $scope.relationship_id = response.data.id;
                $('#unfollow_btn').removeClass('hide');
                $('#follow_btn').addClass('hide');
            }, function (errors) {
                //console.log(errors.data);
            })
        
    }
    $scope.unfollow = function () {
        relationships.deleteRelationships($scope.relationship_id)
            .then(function(){
                $scope.relationship_id = null;
                $('#follow_btn').removeClass('hide');
                $('#unfollow_btn').addClass('hide');
            }, function (errors) {
                //console.log(errors.data);
            })
    }

}
function rateController($scope) {
    
}
function followingController($scope, relationships) {
    $scope.follow = function (company_id) {
        relationships.createRelationships({ followed_id: company_id })
            .then(function (response) {
                $('#unfollow_btn-'+company_id).removeClass('hide');
                $('#follow_btn-'+company_id).addClass('hide');
            }, function (errors) {
                //console.log(errors.data);
            })

    }
    $scope.unfollow = function (company_id) {
        relationships.deleteRelationshipsByCompanyId(company_id)
            .then(function () {
                $('#follow_btn-'+company_id).removeClass('hide');
                $('#unfollow_btn-'+company_id).addClass('hide');
            }, function (errors) {
                //console.log(errors.data);
            })
    }
}
function reviewsService($http) {
    var urlBase = '/companies';
    this.getCurrentReview = function (companyId) {
        return $http.get(urlBase + '/' + companyId + '/reviews/current_review', {
            params: { company_id: companyId }
        });
    }
    this.getReviews = function (companyId, page) {
        return $http.get(urlBase + '/' + companyId + '/reviews', {
            params: { company_id: companyId, page: page }
        });
    }
    this.createReview = function (review, company_id) {
        return $http.post(urlBase + '/' + company_id + '/reviews', review);
    }
    this.updateReview = function (review, company_id) {
        return $http.put(urlBase + '/' + company_id + '/reviews' + '/' + review.id, review);
    };
    this.deleteReview = function (id, company_id) {
        return $http.delete(urlBase + '/' + company_id + '/reviews/' + id + '.json');
    };
}
function relationshipsService($http) {
    var urlBase = '/relationships';
    this.createRelationships = function (relationships) {
        return $http.post(urlBase, relationships);
    }
    this.deleteRelationships = function (id) {
        return $http.delete(urlBase + '/' + id);
    };
    this.deleteRelationshipsByCompanyId = function (id) {
        return $http.delete('/destroy_relationship_by_company/' + id);
    };
}

function companiesService($http) {
    var urlBase = '/companies'
    this.getCompanies = function () {
        return $http.get(urlBase, {
            params: { page: $scope.page }
        });
    };
    this.getCompaniesByPage = function (page, term) {
        return $http.get(urlBase, {
            params: { page: page, term: term }
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
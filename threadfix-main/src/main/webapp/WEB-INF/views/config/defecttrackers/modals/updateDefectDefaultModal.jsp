<script type="text/ng-template" id="updateDefectDefaultModal.html">
    <div class="modal-header">
        <h4 id="myModalLabel">
            Set Defect Defaults
        </h4>
    </div>
    <div ng-form="form" class="modal-body">
        <div ng-hide="initialized" class="modal-spinner-div"><span class="spinner dark"></span>Loading</div>

        <div ng-show="initialized" id="available-tags-div">Available default tags
            <a class="btn" popover="Copy a tag into a text field to set a dynamic default for defect submissions. Some of the tags support value mapping for the select fields. Without a tag, a default will be statically saved." popover-placement="bottom" popover-append-to-body="true">?</a>
            <span ng-repeat="defaultTag in defaultTags" class="default-tag" popover="{{ defaultTag.description }}" popover-trigger="mouseenter" popover-append-to-body="true">@{{ defaultTag.name }}</span>
        </div>

        <div class="dynamic-defect-form" ng-if="isDynamicForm">
            <span ng-if="stdFormTemplate && hasFields" class="errors">* required for defect submissions</span>
            <dynamic-form ng-if="stdFormTemplate" template="stdFormTemplate"
                          ng-model="fieldsMap">
            </dynamic-form>
        </div>

        <div ng-if="!isDynamicForm">

            <table ng-show="initialized" class="dataTable" style="text-align: left">
                <tbody>
                    <tr ng-show="config.typeName === 'Version One' || config.typeName === 'Bugzilla' || config.typeName === 'Jira'">
                        <td ng-show="config.typeName === 'Version One'">Sprint</td>
                        <td ng-show="config.typeName === 'Bugzilla' || config.typeName === 'Jira'">Component</td>
                        <td class="inputValue">
                            <select ng-model="object.selectedComponent" name="selectedComponent" ng-options="component for component in config.components"></select>
                        </td>
                    </tr>
                    <tr>
                        <td>Priority</td>
                        <td class="inputValue">
                            <select ng-model="object.priority" name="priority" ng-options="priority for priority in config.priorities"></select>
                        </td>
                    </tr>
                    <tr>
                        <td>Status</td>
                        <td class="inputValue">
                            <select ng-model="object.status" name="status" ng-options="status for status in config.statuses"></select>
                        </td>
                    </tr>
                    <tr ng-show="config.typeName === 'Bugzilla' || config.typeName === 'HP Quality Center'">
                        <td>Version</td>
                        <td class="inputValue">
                            <select ng-model="object.version" name="version" ng-options="version for version in config.versions"></select>
                        </td>
                    </tr>
                    <tr ng-show="config.typeName === 'Bugzilla' || config.typeName === 'HP Quality Center'">
                        <td>Severity</td>
                        <td class="inputValue">
                            <select ng-model="object.severity" name="severity" ng-options="severity for severity in config.severities"></select>
                        </td>
                    </tr>
                    <tr>
                        <td>Title</td>
                        <td colspan="5" class="inputValue">
                            <input focus-on="focusInput" required style="width:549px;" type="text" ng-model="object.summary" name="summary"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Include Scanner Detail</td>
                        <td class="inputValue">
                            <input ng-model="object.additionalScannerInfo" name="additionalScannerInfo" type="checkbox"/>
                        </td>
                    </tr>
                    <tr style="margin-top:5px;">
                        <td>Description</td>
                        <td colspan="5" class="inputValue">
                            <textarea name="preamble" ng-model="object.preamble" style="width:549px; height:100px;"></textarea>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

       <%--@ include file="../vulnerabilities/littleVulnTable.jspf" --%>
    </div>
    <div class="modal-footer">
        <span class="errors" style="float:left">{{ errorMessage }}</span>

        <a class="btn" ng-click="cancel()">Close</a>
        <button id="loadingButton"
                disabled="disabled"
                class="btn btn-primary"
                ng-show="loading">
            <span class="spinner"></span>
            Submitting
        </button>
        <button id="submit"
                ng-if="hasFields"
                ng-class="{ disabled : form.$invalid }"
                class="btn btn-primary"
                ng-mouseenter="form.summary.$dirty = true"
                ng-hide="loading"
                ng-click="ok(form)">Update Defaults</button>
    </div>
</script>
